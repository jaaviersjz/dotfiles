# Dotfiles
- This repository contains the _dotfiles_ currently used in my **Arch Linux** setup.
- My goal was to create an _elegant_, _functional_ and _productive_ environment.

# Components
## Cava
 - Cava is an audio visualizer for the terminal. I have configured it to display the
   audio bars with a nice blue gradient.
## Fastfetch
 - Fastfetch is a system information tool that displays various details about the system
   in the terminal. I have customized it to show specific information in a visually appealing
   format, including an arch logo image.
## Kitty
 - Kitty is an incredible terminal emulator, wich enables the visualization of images directly
   in the terminal. I have configured in order to obtain some transparency and use an specific
   font. 
## Swaync
 - Swaync is a notification daemon for Wayland. I have set it up to display notification sin the 
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
 - Waybar is a highly customizable status bar for Wayland. I have configured to display useful 
   information with a clean look. From left to right:

## Tmux
 
## Extras
 - I use *Swayosd-client* in order to display audio and brightness changes with a nice bar at 
   the bottom of the screen.
 - I use a theme for *grub* called *space-isolation* (locate in the folder `boot/grub/themes`.
 - I have personalized *GTK settings*. I use the _Adwaita_ icon theme and the _Bibata-Moder-Ice_ cursor.
   I use the _catppuccin-mocha-sapphire-standard+default_ color scheme for GTK applications. 
