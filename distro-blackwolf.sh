#!/bin/bash
# A script for making a blackwolf-linux

#yay

$sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

#Distrobox
$curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local

#Podman
$curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/extras/install-podman | sh -s -- --prefix ~/.local

$HOME/.local/bin
$HOME/.local/podman/bin

$sudo pacman -S xhost
$xhost +si:localuser:$USER

$distrobox-create -n blackwolf-linux

$distrobox-enter Blackolfwolf-linux --root

$sudo pacman -Syu

#Enter Blackarch

$curl -O https://blackarch.org/strap.sh

$chmod +x strap.sh

$sudo ./strap.sh

$sudo pacman -Syu

echo Done! 

