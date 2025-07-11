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

$distrobox create -i docker.io/library/archlinux -n blackwolf-linux

$sudo pacman -Syu

#Enter Blackarch

$curl -O https://blackarch.org/strap.sh

$chmod +x strap.sh

$sudo ./strap.sh

$sudo pacman -Syu

echo "adding packages through 'YAY'"
# Arch packages install using (YAY)
#
yay -S alacritty alsa-oss alsa-plugins alsa-utils amd-ucode arcolinux-app-glade-git arcolinux-betterlockscreen arcolinux-logout autotiling b43-fwcutter base base-devel bind blackarch-keyring brltty broadcom-wl btrbk btrfs-assistant btrfs-progs btrfsmaintenance chaotic-keyring chaotic-mirrorlist chromium clonezilla cloud-init cryptsetup darkhttpd ddrescue dhclient dhcpcd diffutils dmenu dmidecode dmraid dnsmasq dosfstools duf dunst e2fsprogs edk2-shell efibootmgr espeakup ethtool exfatprogsf2fs-tools fatresize fluent-gtk-theme-git foot-terminfo fsarchiver git gitg gitui gnu-netcat gpart gpm gptfdisk grub grub-btrfs gvfs gvfs-goa gvfs-google gvfs-gphoto2 hdparm hyperv i3-gaps-rounded-git i3blocks i3status intel-ucode irssi iw iwd jetbrains-toolbox jfsutils kitty kitty-terminfo less lftp libfido2 librewolf librewolf-extension-bitwarden librewolf-extension-localcdn librewolf-extension-xdm-browser-monitor librewolf-ublock-origin libusb-compat linux linux atm linux-firmware linux-firmware-marvell linux-lts linux-lts-docs linux-lts-headers linux-xanmod-lts linux-xanmod-rt-headers livecd-sounds lsscsi lvm2 lxappearance lynx man-db man-pages mc mdadm memtest86+ memtest86+-efi mkinitcpio mkinitcpio-nfs-utils mkinitcpio-openswap modemmanager mousepad mtools nano nbd ndisc6 neofetch neovim network-manager-applet nfs-utils nilfs-utils nitrogen nmap ntfs-3g nvme oh-my-zsh-git open-iscsi open-vm-tools openconnect openssh openvpn os-prober pacui parole partclone parted partimage pasystray pavucontrol pcsclite pfetch picom pipewire-alsa polkit-gnome polkit-qt5 polybar-git polybar-scripts-git polybar-themes-git powerline ppp pptpclient pulseaudio pulseaudio-jack pulseaudio-qt pv python-click-completion python-pip python-qmake2cmake qconf qemu-guest-agent refind reflector reflector-simple reiserfsprogs ristretto rofi rp-pppoe rsync rxvt-unicode-terminfo screen sddm-config-editor-git sddm-git sddm-theme-astronaut sdparm sg3_utils smartmontools snap-pac snap-pac-grub snapper snapper-gui-git sof-firmware sweet-folders-icons-git syslinux system-config-printer system76-acpi-dkms system76-dkms  system76-power systemd-resolvconf tcpdump terminator terminus-font testdisk thunar-archive-plugin thunar-extended thunar-media-tags-plugin thunar-volman tlp tlp-rdw tlpui tmux tmuxp tpm2-tss ttf-hack ttf-hack-ligatured ttf-hack-nerd ttf-hackgen ttf-jetbrains-mono ttf-jetbrains-mono-nerd udftools usb_modeswitch usbmuxd usbutils vim virtualbox-guest-utils-nox volumeicon vpnc wezterm-terminfo wireless regdb wireless_tools wpa_supplicant wvdial xfburn xfce4-artwork xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-dict xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-netload-plugin xfce4-notes-plugin xfce4-notifyd xfce4-power-manager xfce4-pulseaudio-plugin xfce4-screensaver xfce4-screenshooter xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-taskmanager xfce4-terminal xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin xfsprogs xfwm4-themes xl2tpd  xts-arcolinux-theme zsh zsh-autosuggestions zsh completions zsh-doc zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k

#copying files and directories where they need to do
$sudo cp ~Blackwolf-linux/config2 ~.config/i3/configW
$sudo cp -d ~Wallpapers ~Pictures/

echo Done!
echo Please reboot system now.
echo Press "sudo reboot!"
