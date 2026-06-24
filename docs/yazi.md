# Yazi Tutorial

Yazi is a terminal file manager with Vim-style navigation, previews, tabs,
search, and file operations. This repository configures it with the same
Catppuccin Mocha theme as Kitty.

## Setup

Clone the dotfiles repository to `~/dotfiles`, then run:

```sh
cd ~/dotfiles
stow --target="$HOME" yazi
```

This creates `~/.config/yazi` as a link to the configuration in this
repository.

Recommended dependencies:

| Program | Purpose |
| --- | --- |
| A Nerd Font | File and directory icons |
| `fd` | File-name search |
| `ripgrep` (`rg`) | File-content search |
| `fzf` | Interactive file and directory jump |
| `pdftoppm` | PDF previews |
| Kitty | Best match for the configured theme and image previews |
| `xdg-utils` | Opening files on Linux with `xdg-open` |

On macOS, these can be installed with Homebrew:

```sh
brew install yazi stow fd ripgrep fzf poppler
```

On Linux, use the equivalent packages from your distribution.

### Shell wrapper

Add this to `~/.zshrc`:

```sh
source "${XDG_CONFIG_HOME:-$HOME/.config}/yazi/shell-wrapper.zsh"
```

Reload the shell:

```sh
source ~/.zshrc
```

Launch Yazi with:

```sh
y
```

The `y` function changes the shell to the directory where you quit Yazi. Run
`yazi` directly when you do not want Yazi to change the shell's directory.

## Interface

The default layout has three panes:

1. The left pane shows the parent directory.
2. The middle pane shows the current directory.
3. The right pane previews the selected entry.

The status bar shows the current mode, selected file information, permissions,
and position in the directory.

Most two-key bindings are entered sequentially. For example, `g D` means press
`g`, release it, and then press `D`.

## Essential workflow

Use `j` and `k` to select an entry, then:

- Press `l` to enter a directory.
- Press `h` to return to its parent.
- Press `Enter` to open a file.
- Press `O` to choose how a file should be opened.
- Press `Space` to select multiple files.
- Press `y` to copy or `x` to cut selected files.
- Navigate to the destination and press `p` to paste.
- Press `q` to quit.

## Keybindings

### Navigation

| Key | Action |
| --- | --- |
| `j` / `Down` | Move to the next entry |
| `k` / `Up` | Move to the previous entry |
| `h` / `Left` | Go to the parent directory |
| `l` / `Right` | Enter the selected directory |
| `H` | Go backward in directory history |
| `L` | Go forward in directory history |
| `gg` | Move to the top |
| `G` | Move to the bottom |
| `Ctrl-u` / `Ctrl-d` | Move half a page up/down |
| `Ctrl-b` / `Ctrl-f` | Move one page up/down |
| `K` / `J` | Scroll the preview up/down |
| `Tab` | Show detailed information for the selected file |

### Opening and file operations

| Key | Action |
| --- | --- |
| `Enter` / `o` | Open selected entries |
| `O` | Choose an opener interactively |
| `a` | Create a file; end the name with `/` to create a directory |
| `r` | Rename selected entries |
| `Space` | Toggle selection and move down |
| `v` | Start visual selection mode |
| `V` | Start visual deselection mode |
| `Ctrl-a` | Select all entries |
| `Ctrl-r` | Invert the selection |
| `y` | Copy selected entries |
| `x` | Cut selected entries |
| `p` | Paste |
| `P` | Paste and overwrite conflicts |
| `Y` / `X` | Cancel copy or cut state |
| `-` | Create absolute symbolic links from copied entries |
| `_` | Create relative symbolic links from copied entries |
| `d` | Move selected entries to the trash |
| `D` | Permanently delete selected entries |

`D` bypasses the trash. Check the confirmation dialog carefully.

### Search and filtering

| Key | Action |
| --- | --- |
| `f` | Filter entries in the current directory |
| `/` | Find the next matching entry |
| `?` | Find the previous matching entry |
| `n` / `N` | Move to the next/previous match |
| `s` | Search file names recursively with `fd` |
| `S` | Search file contents recursively with `ripgrep` |
| `Ctrl-s` | Cancel an active search |
| `z` | Jump to a file or directory with `fzf` |
| `.` | Toggle hidden files |

### Quick directories

| Key | Action |
| --- | --- |
| `g h` | Go to the home directory |
| `g c` | Go to `~/.config` |
| `g d` | Go to `~/Downloads` |
| `g D` | Go to `~/dotfiles` |
| `g Space` | Enter a directory path interactively |
| `g f` | Follow the selected symbolic link |

The custom `g D` binding assumes this repository is cloned to `~/dotfiles`.
Change it in `yazi/.config/yazi/keymap.toml` if the repository is elsewhere.

### Tabs

| Key | Action |
| --- | --- |
| `t` | Create a tab at the current directory |
| `1`–`9` | Switch to a numbered tab |
| `[` / `]` | Switch to the previous/next tab |
| `{` / `}` | Move the current tab left/right |
| `Ctrl-c` | Close the current tab, or quit if it is the last tab |

### Sorting and displayed metadata

| Key | Action |
| --- | --- |
| `, n` / `, N` | Sort naturally forward/reverse |
| `, a` / `, A` | Sort alphabetically forward/reverse |
| `, m` / `, M` | Sort by modification time forward/reverse |
| `, b` / `, B` | Sort by creation time forward/reverse |
| `, e` / `, E` | Sort by extension forward/reverse |
| `, s` / `, S` | Sort by size forward/reverse |
| `, r` | Sort randomly |
| `m s` | Display file sizes |
| `m p` | Display permissions |
| `m m` | Display modification times |
| `m b` | Display creation times |
| `m o` | Display owners |
| `m n` | Hide metadata |

Directories remain before files with this configuration.

### Paths, commands, tasks, and help

| Key | Action |
| --- | --- |
| `c c` | Copy the selected path to the clipboard |
| `c d` | Copy the containing directory path |
| `c f` | Copy the file name |
| `c n` | Copy the file name without its extension |
| `;` | Run a shell command without blocking Yazi |
| `:` | Run a shell command and wait for it to finish |
| `w` | Show the task manager |
| `~` / `F1` | Show Yazi's complete interactive help |
| `Esc` | Cancel the current mode, selection, or search |
| `q` | Quit and let the `y` wrapper change directory |
| `Q` | Quit without changing the shell directory |

## Platform behavior

On macOS, files are opened with `open`, and reveal opens Finder with the file
selected. On Linux, files are opened with `xdg-open`, and reveal opens the
containing directory with the system file manager.

The configuration itself works on both macOS and Linux. Visual results depend
on the terminal, installed Nerd Font, and preview utilities available on the
machine.

## Updating and removing

After pulling configuration changes, the existing Stow link immediately uses
the new files:

```sh
cd ~/dotfiles
git pull
```

If the package is not linked, run `stow --target="$HOME" yazi` again.

Remove the links without deleting the repository files:

```sh
cd ~/dotfiles
stow --target="$HOME" --delete yazi
```
