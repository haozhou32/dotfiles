# Sioyek Keybindings

This repository adds a small set of single-key Sioyek bindings and a
Gruvbox-style color configuration. The custom bindings come from
`sioyek/.config/sioyek/keys_user.config`.

Bindings are case-sensitive. For example, `P` means `Shift-P`, while `p` is a
different key.

## Setup

The macOS installer installs Sioyek when its Homebrew cask is available and
applies the configuration:

```sh
cd ~/dotfiles
./install.sh
```

To apply only the Sioyek Stow package:

```sh
cd ~/dotfiles
stow --target="$HOME" sioyek
```

## Custom keybindings

| Key | Action |
| --- | --- |
| `r` | Toggle the configured custom color mode |
| `P` | Toggle presentation mode |
| `w` | Fit the page to the window width |
| `e` | Fit the page to the window height |
| `f` | Toggle fullscreen |
| `L` | Move forward in viewing history |
| `H` | Move backward in viewing history |
| `u` | Reload the current document |
| `s` | Toggle SyncTeX mode |

These user bindings take precedence over built-in bindings assigned to the
same keys. In particular, the configured `r`, `P`, `f`, and `s` actions replace
Sioyek's default rotate-clockwise, edit-portal, open-link, and external-search
bindings on those keys.

## Selected built-in bindings

Other built-in Sioyek bindings remain available. Common ones include:

| Key | Action |
| --- | --- |
| `Space` / `Shift-Space` | Move down/up one screen |
| `gg` / `G` | Go to the beginning/end of the document |
| `t` | Open the table of contents |
| `+` / `-` | Zoom in/out |
| `=` | Fit the page to the window width |
| `o` | Open a document |
| `O` | Open the recent-documents list |
| `/` | Search the document |
| `n` / `N` | Go to the next/previous search result |
| `b` | Add a bookmark |
| `gb` | Open bookmarks for the current document |
| `h` | Highlight selected text |
| `gh` | Open highlights for the current document |
| `m` followed by a letter | Set a named mark |
| `` ` `` followed by a letter | Go to a named mark |
| `q` | Quit Sioyek |

Sioyek's built-in defaults are supplied by the installed application and may
change between versions. Use the command palette with `:` or inspect Sioyek's
`keys.config` to see the complete defaults for the installed version.

## Startup behavior

On startup, the configuration runs:

```text
toggle_custom_color;fit_to_page_height;toggle_synctex
```

This enables the custom dark color scheme, fits the document to the window
height, and enables SyncTeX mode. Use `r`, `e`, and `s` to change those states
while Sioyek is running.

## SyncTeX inverse search

When SyncTeX data is available, right-clicking a PDF location invokes:

```sh
nvim --headless -c "VimtexInverseSearch %2 '%1'"
```

Sioyek replaces `%1` with the source file and `%2` with the source line
number. This requires Neovim, VimTeX, and a PDF built with SyncTeX metadata.

If inverse search is not wanted for the current session, press `s` to disable
SyncTeX mode.
