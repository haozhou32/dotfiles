# Yabai and skhd Keybindings

Yabai manages windows, while skhd listens for keyboard shortcuts and runs the
corresponding Yabai commands. The bindings below come from
`skhd/.config/skhd/skhdrc`.

On a Mac keyboard, `Alt` means `Option`.

## Setup

The macOS installer installs and configures Yabai, skhd, and the window border
helper:

```sh
cd ~/dotfiles
./install.sh
```

After installation, grant both Yabai and skhd access under **System Settings >
Privacy & Security > Accessibility**, then restart them:

```sh
yabai --restart-service
skhd --restart-service
```

Under **System Settings > Desktop & Dock > Mission Control**:

- Enable **Displays have separate Spaces**.
- Disable **Automatically rearrange Spaces based on most recent use**.

Secure Keyboard Entry must be disabled for skhd to receive shortcuts.

## Keybindings

### Applications and services

| Key | Action |
| --- | --- |
| `Option-Return` | Open a new Kitty window |
| `Shift-Option-R` | Restart Yabai and reload the skhd configuration |

### Window state

| Key | Action |
| --- | --- |
| `Option-X` | Close the focused window |
| `Option-M` | Minimize the focused window |
| `Option-D` | Toggle the focused window between tiled and floating |
| `Option-P` | Toggle parent-container zoom |
| `Option-F` | Toggle Yabai zoom-fullscreen |

Yabai zoom-fullscreen expands a managed window within its current space. It is
different from macOS native fullscreen, which moves a window into a separate
space.

### Focus and movement

| Key | Action |
| --- | --- |
| `Option-H` | Focus the window to the west |
| `Option-J` | Focus the window to the south |
| `Option-K` | Focus the window to the north |
| `Option-L` | Focus the window to the east |
| `Shift-Option-H` | Swap the focused window with the window to the west |
| `Shift-Option-J` | Swap the focused window with the window to the south |
| `Shift-Option-K` | Swap the focused window with the window to the north |
| `Shift-Option-L` | Swap the focused window with the window to the east |
| `Option-R` | Rotate the current BSP layout by 270 degrees |

## Mouse controls

The Yabai configuration also defines these mouse actions:

| Input | Action |
| --- | --- |
| `Option` + primary-button drag | Move a window |
| `Option` + secondary-button drag | Resize a window |
| Drop one managed window onto another | Swap the windows |

## Window-management behavior

The current configuration uses a BSP layout with 12-pixel outer padding,
9-pixel window gaps, and visible active/inactive window borders.

These applications are excluded from Yabai management:

- System Settings
- Calculator
- Zoom
- Stickies

The optional Yabai scripting addition is not enabled. The documented
keybindings do not require it, but some advanced Yabai features do.

## Reloading changes

After editing `skhdrc`, reload its shortcuts with:

```sh
skhd --reload
```

After editing `yabairc`, restart Yabai with:

```sh
yabai --restart-service
```
