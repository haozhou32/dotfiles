# tmux Keybindings

This configuration changes the tmux prefix from the default `Ctrl-B` to
`Ctrl-Space`.

In the tables below, `Prefix` means press `Ctrl-Space`, release it, and then
press the listed key. Bindings marked repeatable can be pressed repeatedly
without entering the prefix again while tmux's repeat timer is active.

## Setup

The macOS installer installs tmux and applies this configuration:

```sh
cd ~/dotfiles
./install.sh
```

To apply only the tmux Stow package:

```sh
cd ~/dotfiles
stow --target="$HOME" tmux
```

## General bindings

| Key | Action |
| --- | --- |
| `Prefix Ctrl-Space` | Send a literal `Ctrl-Space` to the program inside the pane |
| `Prefix r` | Reload `~/.config/tmux/tmux.conf` |
| `Prefix o` | Create a new window in the current pane's directory |
| `Prefix k` | Confirm, then kill the current window |
| `Prefix f` | Toggle zoom for the current pane |
| `Prefix Space` | Switch to the next pane layout |

## Creating panes

All four split bindings preserve the current pane's working directory.

| Key | Action |
| --- | --- |
| `Prefix \|` | Split into side-by-side panes |
| `Prefix -` | Split into top-and-bottom panes |
| `` Prefix \ `` | Create a full-height side-by-side pane |
| `Prefix _` | Create a full-width top-and-bottom pane |

## Moving, resizing, and joining panes

| Key | Action |
| --- | --- |
| `Prefix .` | Swap with the next pane; repeatable |
| `Prefix ,` | Swap with the previous pane; repeatable |
| `Prefix Ctrl-H` | Resize 15 cells to the left; repeatable |
| `Prefix Ctrl-J` | Resize 15 cells downward; repeatable |
| `Prefix Ctrl-K` | Resize 15 cells upward; repeatable |
| `Prefix Ctrl-L` | Resize 15 cells to the right; repeatable |
| `Prefix j` | Choose a window and join one of its panes beside the current pane |
| `Prefix J` | Choose a window and join one of its panes below the current pane |

## Marked panes

tmux's standard mark commands are retained and combined with a custom jump
binding:

| Key | Action |
| --- | --- |
| `Prefix m` | Mark the current pane |
| `Prefix M` | Clear the marked pane |
| `` Prefix ` `` | Jump to the marked pane |

Only one pane can be marked at a time.

## Copy mode

Copy mode uses Vim-style movement.

| Key | Context | Action |
| --- | --- | --- |
| `Prefix [` | Normal mode | Enter copy mode |
| `h`, `j`, `k`, `l` | Copy mode | Move the cursor |
| `v` | Copy mode | Begin a character-wise selection |
| `Ctrl-V` | Copy mode | Toggle rectangular selection |
| `y` | Copy mode | Copy the selection and leave copy mode |
| `q` | Copy mode | Leave copy mode |

## Useful retained tmux defaults

Bindings not replaced by this configuration continue to use tmux defaults.
Common examples include:

| Key | Action |
| --- | --- |
| `Prefix c` | Create a new window |
| `Prefix n` / `Prefix p` | Select the next/previous window |
| `Prefix 1`–`9` | Select a numbered window |
| `Prefix w` | Choose a window interactively |
| `Prefix s` | Choose a session interactively |
| `Prefix d` | Detach the current client |
| `Prefix ?` | Display all active keybindings |

## Plugin bindings

TPM and the configured plugins are installed lazily when tmux first starts.
Once TPM is available:

| Key | Action |
| --- | --- |
| `Prefix I` | Install new plugins |
| `Prefix U` | Update plugins |
| `Prefix Option-u` | Remove plugins no longer listed in `tmux.conf` |

Plugin files are stored under `~/.config/tmux/plugins` and are intentionally
not tracked by this dotfiles repository.

## Mouse support

Mouse support is enabled. You can select panes, resize pane borders, select
windows in the status bar, and scroll into copy mode using the mouse or
trackpad.
