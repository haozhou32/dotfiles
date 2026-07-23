#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BREW_BIN=""

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

require_macos() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "This installer only supports macOS." >&2
    exit 1
  fi
}

append_shell_line() {
  local file="$1"
  local comment="$2"
  local line="$3"

  touch "$file"
  if ! grep -Fqx "$line" "$file"; then
    printf '\n# %s\n%s\n' "$comment" "$line" >>"$file"
  fi
}

install_homebrew() {
  #################### HOMEBREW ####################
  if command_exists brew; then
    BREW_BIN="$(command -v brew)"
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    BREW_BIN="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    BREW_BIN="/usr/local/bin/brew"
  else
    local homebrew_installer

    echo "Installing Homebrew..."
    homebrew_installer="$(
      curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    )"
    /bin/bash -c "$homebrew_installer"

    if [[ -x /opt/homebrew/bin/brew ]]; then
      BREW_BIN="/opt/homebrew/bin/brew"
    elif [[ -x /usr/local/bin/brew ]]; then
      BREW_BIN="/usr/local/bin/brew"
    else
      echo "Homebrew installation completed, but brew could not be found." >&2
      exit 1
    fi
  fi

  eval "$("$BREW_BIN" shellenv)"

  local shellenv_line
  shellenv_line="eval \"\$($BREW_BIN shellenv)\""
  append_shell_line "$HOME/.zprofile" "Homebrew" "$shellenv_line"
}

install_base_packages() {
  # Stow is required before any dotfile package can be configured. Git is
  # used by TPM to lazily download tmux plugins, and jq is used by SketchyBar.
  brew install git stow jq
}

stow_package() {
  local package="$1"

  if ! stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$package"; then
    echo "Could not Stow the $package configuration." >&2
    echo "Back up conflicting files under ~/.config/$package, then rerun this script." >&2
    exit 1
  fi
}

configure_xdg() {
  local xdg_line='export XDG_CONFIG_HOME="$HOME/.config"'

  if ! grep -Eq '^[[:space:]]*(export[[:space:]]+)?XDG_CONFIG_HOME=' \
    "$HOME/.zshrc" 2>/dev/null; then
    append_shell_line "$HOME/.zshrc" "XDG configuration directory" "$xdg_line"
  fi

  export XDG_CONFIG_HOME="$HOME/.config"
  mkdir -p "$XDG_CONFIG_HOME"
}

install_terminal() {
  #################### KITTY AND TMUX ####################
  brew install tmux
  brew install --cask kitty font-dejavu-sans-mono-nerd-font

  stow_package kitty
  stow_package tmux

  echo "Kitty and tmux are installed and configured."
  echo "TPM and the configured tmux plugins will be installed on first launch."
}

install_yazi() {
  #################### YAZI ####################
  brew install \
    yazi ffmpeg sevenzip poppler fd ripgrep fzf zoxide resvg imagemagick
  brew install --cask font-symbols-only-nerd-font

  stow_package yazi

  local source_line='source "${XDG_CONFIG_HOME:-$HOME/.config}/yazi/shell-wrapper.zsh"'
  append_shell_line "$HOME/.zshrc" "Yazi shell wrapper" "$source_line"

  echo "Yazi is installed and configured."
}

install_sioyek() {
  #################### SIOYEK ####################
  if ! brew list --cask sioyek >/dev/null 2>&1; then
    local cask_info

    if ! cask_info="$(brew info --json=v2 --cask sioyek 2>/dev/null)"; then
      echo "Homebrew does not provide the Sioyek cask; skipping Sioyek."
      return
    fi

    if printf '%s' "$cask_info" |
      jq -e '.casks[0].disabled == true' >/dev/null; then
      echo "The Sioyek cask is disabled in Homebrew; skipping Sioyek."
      return
    fi

    brew install --cask sioyek
  fi

  # The Sioyek inverse-search configuration invokes nvim.
  brew install neovim
  stow_package sioyek

  echo "Sioyek is installed and configured."
}

install_window_manager() {
  #################### YABAI AND SKHD ####################
  brew tap asmvik/formulae
  brew tap FelixKratz/formulae
  brew install \
    asmvik/formulae/yabai \
    asmvik/formulae/skhd \
    FelixKratz/formulae/borders

  stow_package yabai
  stow_package skhd

  yabai --start-service
  skhd --start-service

  echo "Yabai and skhd are installed, configured, and started."
  echo "Grant both applications access in:"
  echo "System Settings > Privacy & Security > Accessibility"
  echo "In System Settings > Desktop & Dock > Mission Control:"
  echo "- Enable 'Displays have separate Spaces'."
  echo "- Disable 'Automatically rearrange Spaces based on most recent use'."
  echo "Secure Keyboard Entry must be disabled for skhd to receive shortcuts."
  echo "Then restart them with: yabai --restart-service; skhd --restart-service"
  echo "The optional Yabai scripting addition is not configured."
}

install_sketchybar() {
  #################### SKETCHYBAR ####################
  local app_font="$HOME/Library/Fonts/sketchybar-app-font.ttf"
  local helper_source="$DOTFILES_DIR/sketchybar/.config/sketchybar/helper/helper.c"
  local helper_binary="$HOME/Library/Caches/sketchybar/helper"

  brew tap FelixKratz/formulae
  brew install sketchybar switchaudio-osx
  brew install --cask sf-symbols font-sf-pro

  mkdir -p "$HOME/Library/Fonts"
  if [[ ! -f "$app_font" ]]; then
    curl -fL \
      https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf \
      -o "$app_font"
  fi

  stow_package sketchybar

  # The helper committed to the repository is x86_64. Build a native copy so
  # the configuration works on both Intel and Apple Silicon Macs.
  mkdir -p "$(dirname "$helper_binary")"
  clang -std=c99 -O3 "$helper_source" -o "$helper_binary"

  brew services restart sketchybar
  echo "SketchyBar is installed, configured, and running."
}

install_claude() {
  #################### CLAUDE CODE ####################
  # Claude Code uses ~/.claude/ directly (not ~/.config/claude/).

  brew install --cask claude-code

  if [[ ! -d "$HOME/.claude" ]]; then
    echo "Claude Code installation succeeded but ~/.claude was not found." >&2
    exit 1
  fi

  # Remove default files that Claude Code created so stow can replace
  # them with symlinks into the dotfiles package.
  for file in settings.json; do
    local target="$HOME/.claude/$file"
    if [[ -f "$target" ]] && [[ ! -L "$target" ]]; then
      rm "$target"
    fi
  done

  stow_package claude

  echo "Claude Code is configured."
}

main() {
  require_macos
  install_homebrew
  install_base_packages
  configure_xdg
  install_terminal
  install_yazi
  install_sioyek
  install_window_manager
  install_sketchybar
  install_claude

  echo
  echo "Installation complete."
  echo "Restart Zsh or run: source \"$HOME/.zshrc\""
  echo "Launch Yazi with: y"
}

main "$@"
