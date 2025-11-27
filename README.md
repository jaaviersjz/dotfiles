# 🚀 Dotfiles
- This repository contains the _dotfiles_ currently used in my **Arch Linux** setup.
- My goal was to create an _elegant_, _functional_ and _productive_ environment. ✨

# ⚙️ Components

## Cava
 - Cava is an audio visualizer for the terminal. I have configured it to display the
   audio bars with a nice blue gradient.

## Fastfetch
 - Fastfetch is a system information tool that displays various details about the system
   in the terminal. I have customized it to show specific information in a visually appealing
   format, including an Arch logo image.

## Kitty
 - Kitty is an incredible terminal emulator, which enables the visualization of images directly
   in the terminal. I have configured it in order to obtain some transparency and use a specific
   font. 

## Swaync
 - Swaync is a notification daemon for Wayland. I have set it up to display notifications in the 
   upper right corner of the screen with a minimalistic design.

## .pkglist.txt
 - This file contains a list of all the packages I have installed on my system using *pacman* or 
   *yay* (an AUR helper). It stays updated via a pacman hook activated after a new package is 
   installed or an old one is deleted:
```ini
   [Trigger]
   Operation = Install
   Operation = Remove
   Type = Package
   Target = *
   [Action]
   When = PostTransaction
   Exec = /bin/zsh -c '/usr/bin/pacman -Qqe > /home/javier/dotfiles/.pkglist.txt'
```

## Waybar
 - Waybar is a highly customizable status bar for Wayland. I have configured it to display useful 
   information with a clean look. 

## Tmux
 - Tmux is an excellent terminal multiplexer. I have customized it to use vim-like keybindings and change
   its looks.

## Wofi
 - Wofi is an application launcher. Use `Alt+D` to launch an application and use `Alt+W` to dynamically
   select a wallpaper.

## Nvim
 - My Neovim configuration uses **LazyVim** and is heavily inspired by the videos of @typecraft-dev. I have
   added plenty of plugins and features.

## Hyprland
 - My configuration has focused on adding vim-like keybindings to work with windows and workspaces. I also
   added custom keybindings for functionality such as:
   * `nvim-everywhere.sh` (`Alt+N`)
   * `randomWallpaper.sh` (`Alt+Q`)

## Zsh
 - I use [powerlevel10k](https://github.com/romkatv/powerlevel10k) for the prompt. The configuration file
   `.zshrc` contains many aliases and custom functionality (refer to the comments there).

## Extras
 - I use *swayosd-client* in order to display audio and brightness changes with a nice bar at 
   the bottom of the screen.
 - I use a theme for *grub* called *space-isolation* (located in the folder `boot/grub/themes`).
 - I have personalized *GTK settings*. I use the _Adwaita_ icon theme and the _Bibata-Modern-Ice_ cursor.
   I use the _catppuccin-mocha-sapphire-standard+default_ color scheme for GTK applications. 

## Acknowledgements
 - Special thanks to @typecraft-dev for his series of videos on **Arch Linux**, *Neovim*, *Tmux*,
   *Hyprland*, etc.
