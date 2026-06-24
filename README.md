# Dotfiles

On macOS, install and configure SketchyBar, Yabai, skhd, Kitty, tmux, Yazi,
and Sioyek when its Homebrew cask is available:

```sh
./install.sh
```

The installer uses Homebrew, applies the corresponding GNU Stow packages, and
adds the required tmux and Yazi entries to `~/.zshrc`. On a fresh macOS
installation, it installs Homebrew and GNU Stow first.

After installation, grant Yabai and skhd access under **System Settings >
Privacy & Security > Accessibility**, then restart their services:

```sh
yabai --restart-service
skhd --restart-service
```

Under **System Settings > Desktop & Dock > Mission Control**, enable
**Displays have separate Spaces** and disable **Automatically rearrange Spaces
based on most recent use**. Secure Keyboard Entry must also be disabled for
skhd to receive shortcuts.

The installer does not configure Yabai's optional scripting addition because
that requires changing System Integrity Protection and adding a privileged
sudoers rule.

Configuration guides and keybindings:

- [Yabai and skhd](docs/yabai.md)
- [tmux](docs/tmux.md)
- [Yazi](docs/yazi.md)
- [Sioyek](docs/sioyek.md)








