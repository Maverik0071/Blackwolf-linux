########################################
## All Packages Stored on Blackwolf Linux
######################################## 
echo "installing Yay!" Arch linux package helper

sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

echo "Enter Blackarch"
############################

curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syu

echo "Installing chaotic aur"

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

####################################
######## Then, we append (adding at the end) the following to /etc/pacman.conf:
# ###### echo " Add this in /etc/pacman.conf towards the end
# ######                [chaotic-aur]
# ######    Include = /etc/pacman.d/chaotic-mirrorlist "
####################################

sudo pacman -Syu
#################
# Normal Packages
#################

sudo pacman -S --noconfirm --needed alsa-firmware 
sudo pacman -S --noconfirm --needed alsa-plugins 
sudo pacman -S --noconfirm --needed alsa-utils
sudo pacman -S --noconfirm --needed arandr  
sudo pacman -S --noconfirm --needed autotiling
sudo pacman -S --noconfirm --needed base
sudo pacman -S --noconfirm --needed base-devel
sudo pacman -S --noconfirm --needed bash-completion
sudo pacman -S --noconfirm --needed beautyline
sudo pacman -S --noconfirm --needed bind
sudo pacman -S --noconfirm --needed bluez
sudo pacman -S --noconfirm --needed bluez-utils
sudo pacman -S --noconfirm --needed bpytop
sudo pacman -S --noconfirm --needed cantarell-fonts
sudo pacman -S --noconfirm --needed cava
sudo pacman -S --noconfirm --needed chaotic-keyring
sudo pacman -S --noconfirm --neededchaotic-mirrorlist
sudo pacman -S --noconfirm --needed brave-bin
sudo pacman -S --noconfirm --needed cryptsetup
sudo pacman -S --noconfirm --needed cups
sudo pacman -S --noconfirm --needed cups-filters
sudo pacman -S --noconfirm --needed cups-pdf
sudo pacman -S --noconfirm --needed device-mapper
sudo pacman -S --noconfirm --needed dhclient
sudo pacman -S --noconfirm --needed diffutils 
sudo pacman -S --noconfirm --needed distrobox 
sudo pacman -S --noconfirm --needed dmenu
sudo pacman -S --noconfirm --needed dnsmasq
sudo pacman -S --noconfirm --needed docker
sudo pacman -S --noconfirm --needed dosfstools
sudo pacman -S --noconfirm --needed downgrade 
sudo pacman -S --noconfirm --needed dracut
sudo pacman -S --noconfirm --needed duf
sudo pacman -S --noconfirm --needed 2fsprogs 
sudo pacman -S --noconfirm --needed efibootmgr
sudo pacman -S --noconfirm --needed efitools
sudo pacman -S --noconfirm --needed espeak-ng
sudo pacman -S --noconfirm --needed ethtool
sudo pacman -S --noconfirm --needed exfatprogs 
sudo pacman -S --noconfirm --needed f2fs-tools
sudo pacman -S --noconfirm --needed feh
sudo pacman -S --noconfirm --needed ffmpegthumbnailer
sudo pacman -S --noconfirm --needed firefox 
sudo pacman -S --noconfirm --needed firewalld
sudo pacman -S --noconfirm --needed flatpak
sudo pacman -S --noconfirm --needed foomatic-db
sudo pacman -S --noconfirm --needed foomatic-db-engine
sudo pacman -S --noconfirm --needed foomatic-db-gutenprint-ppds 
sudo pacman -S --noconfirm --neededfoomatic-db-nonfree
sudo pacman -S --noconfirm --needed foomatic-db-nonfree-ppds
sudo pacman -S --noconfirm --needed foomatic-db-ppds
sudo pacman -S --noconfirm --needed sarchiver
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed glances
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed gsfonts
sudo pacman -S --noconfirm --needed gst-libav
sudo pacman -S --noconfirm --needed gst-plugin-pipewire
sudo pacman -S --noconfirm --needed gst-plugins-bad
sudo pacman -S --noconfirm --needed gst-plugins-ugly
sudo pacman -S --noconfirm --needed gufw
sudo pacman -S --noconfirm --needed gutenprint
sudo pacman -S --noconfirm --needed gvfs
sudo pacman -S --noconfirm --needed haveged
sudo pacman -S --noconfirm --needed hdparm
sudo pacman -S --noconfirm --needed hplip
sudo pacman -S --noconfirm --needed hwdetect
sudo pacman -S --noconfirm --needed hwinfo
sudo pacman -S --noconfirm --needed i3-wm
sudo pacman -S --noconfirm --needed i3blocks 
sudo pacman -S --noconfirm --needed i3lock
sudo pacman -S --noconfirm --needed i3status
sudo pacman -S --noconfirm --needed inetutils
sudo pacman -S --noconfirm --needed inxi
sudo pacman -S --noconfirm --needed iptables-nft
sudo pacman -S --noconfirm --needed iwd
sudo pacman -S --noconfirm --needed jfsutils
sudo pacman -S --noconfirm --needed jgmenu 
sudo pacman -S --noconfirm --needed kernel-install-for-dracut
sudo pacman -S --noconfirm --needed less
sudo pacman -S --noconfirm --needed libdvdcss
sudo pacman -S --noconfirm --needed libgsf
sudo pacman -S --noconfirm --needed libopenraw
sudo pacman -S --noconfirm --needed libwnck3
sudo pacman -S --noconfirm --needed linux
sudo pacman -S --noconfirm --needed linux-firmware
sudo pacman -S --noconfirm --needed linux-headers
sudo pacman -S --noconfirm --needed linux-zen 
sudo pacman -S --noconfirm --needed linux-zen-headers 
sudo pacman -S --noconfirm --needed logrotate 
sudo pacman -S --noconfirm --needed lsb-release 
sudo pacman -S --noconfirm --needed lsscsi
sudo pacman -S --noconfirm --needed lvm2
sudo pacman -S --noconfirm --needed lxappearance 
sudo pacman -S --noconfirm --needed ly 
sudo pacman -S --noconfirm --needed man-db 
sudo pacman -S --noconfirm --needed man-pages
sudo pacman -S --noconfirm --needed mdadm
sudo pacman -S --noconfirm --needed meld
sudo pacman -S --noconfirm --needed mesa-utils
sudo pacman -S --noconfirm --needed mlocate
sudo pacman -S --noconfirm --needed modemmanager
sudo pacman -S --noconfirm --needed mousepad
sudo pacman -S --noconfirm --needed mousetweaks
sudo pacman -S --noconfirm --needed mtools
sudo pacman -S --noconfirm --needed nano
sudo pacman -S --noconfirm --needed nano-syntax-highlighting
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed netctl
sudo pacman -S --noconfirm --needed networkmanager
sudo pacman -S --noconfirm --needed networkmanager-openconnect
sudo pacman -S --noconfirm --needed networkmanager-openvpn
sudo pacman -S --noconfirm --needed nfs-utils
sudo pacman -S --noconfirm --needed nilfs-utils
sudo pacman -S --noconfirm --needed nitrogen
sudo pacman -S --noconfirm --needed nm-connection-editor
sudo pacman -S --noconfirm --needed nm-tray
sudo pacman -S --noconfirm --needed noto-fonts 
sudo pacman -S --noconfirm --needed nss-mdns 
sudo pacman -S --noconfirm --needed ntfs-3g 
sudo pacman -S --noconfirm --needed ntp 
sudo pacman -S --noconfirm --needed openssh 
sudo pacman -S --noconfirm --needed orca
sudo pacman -S --noconfirm --needed pacman-contrib
sudo pacman -S --noconfirm --needed pacseek
sudo pacman -S --noconfirm --needed papirus-folders
sudo pacman -S --noconfirm --needed papirus-icon-theme 
sudo pacman -S --noconfirm --needed pasystray
sudo pacman -S --noconfirm --needed pavucontrol
sudo pacman -S --noconfirm --needed perl
sudo pacman -S --noconfirm --needed perl-anyevent-i3
sudo pacman -S --noconfirm --needed perl-json-xs
sudo pacman -S --noconfirm --needed pfetch 
sudo pacman -S --noconfirm --needed picom 
sudo pacman -S --noconfirm --needed pipewire-alsa 
sudo pacman -S --noconfirm --needed pipewire-jack 
sudo pacman -S --noconfirm --needed pipewire-pulse
sudo pacman -S --noconfirm --needed pkgfile
sudo pacman -S --noconfirm --needed podman 
sudo pacman -S --noconfirm --needed poppler-glib 
sudo pacman -S --noconfirm --needed popsicle-bin 
sudo pacman -S --noconfirm --needed power-profiles-daemon
sudo pacman -S --noconfirm --needed pv
sudo pacman -S --noconfirm --needed python 
sudo pacman -S --noconfirm --needed python-capng 
sudo pacman -S --noconfirm --needed python-defusedxml 
sudo pacman -S --noconfirm --needed python-packaging 
sudo pacman -S --noconfirm --needed python-pyqt5 
sudo pacman -S --noconfirm --needed python-reportlab 
sudo pacman -S --noconfirm --needed ranger 
sudo pacman -S --noconfirm --needed rebuild-detector
sudo pacman -S --noconfirm --needed reflector 
sudo pacman -S --noconfirm --needed reflector-simple 
sudo pacman -S --noconfirm --needed reiserfsprogs
sudo pacman -S --noconfirm --needed ristretto
sudo pacman -S --noconfirm --needed rofi 
sudo pacman -S --noconfirm --needed rofi-themes-collection-git 
sudo pacman -S --noconfirm --needed rsync 
sudo pacman -S --noconfirm --needed rtkit 
sudo pacman -S --noconfirm --needed s-nail 
sudo pacman -S --noconfirm --needed sg3_utils 
sudo pacman -S --noconfirm --needed smartmontools
sudo pacman -S --noconfirm --needed splix 
sudo pacman -S --noconfirm --needed sudo
sudo pacman -S --noconfirm --needed sweet-folders-icons-git
sudo pacman -S --noconfirm --needed sweet-gtk-theme 
sudo pacman -S --noconfirm --needed sysfsutils 
sudo pacman -S --noconfirm --needed system-config-printer 
sudo pacman -S --noconfirm --needed systemd-sysvcompat 
sudo pacman -S --noconfirm --needed terminus-font 
sudo pacman -S --noconfirm --needed texinfo 
sudo pacman -S --noconfirm --needed thunar 4
sudo pacman -S --noconfirm --needed thunar-archive-plugin
sudo pacman -S --noconfirm --needed thunar-media-tags-plugin 
sudo pacman -S --noconfirm --needed thunar-volman 
sudo pacman -S --noconfirm --needed timeshift 
sudo pacman -S --noconfirm --needed timeshift-systemd-timer 
sudo pacman -S --noconfirm --needed tldr 
sudo pacman -S --noconfirm --needed ttf-bitstream-vera 
sudo pacman -S --noconfirm --needed ttf-dejavu 
sudo pacman -S --noconfirm --needed ttf-jetbrains-mono 
sudo pacman -S --noconfirm --needed ttf-jetbrains-mono-nerd 
sudo pacman -S --noconfirm --needed ttf-liberation 
sudo pacman -S --noconfirm --needed ttf-opensans 
sudo pacman -S --noconfirm --needed ttf-terminus-nerd 
sudo pacman -S --noconfirm --needed ufw 
sudo pacman -S --noconfirm --needed ufw-extras 
sudo pacman -S --noconfirm --needed unrar
sudo pacman -S --noconfirm --needed unzip 
sudo pacman -S --noconfirm --needed update-grub 
sudo pacman -S --noconfirm --needed upower 
sudo pacman -S --noconfirm --needed usb_modeswitch
sudo pacman -S --noconfirm --needed usbutils 
sudo pacman -S --noconfirm --needed vi 
sudo pacman -S --noconfirm --needed vim 
sudo pacman -S --noconfirm --needed volumeicon 
sudo pacman -S --noconfirm --needed wget 
sudo pacman -S --noconfirm --needed which
sudo pacman -S --noconfirm --needed wireplumber 
sudo pacman -S --noconfirm --needed wpa_actiond
sudo pacman -S --noconfirm --needed wpa_supplicant 
sudo pacman -S --noconfirm --needed xdg-user-dirs 
sudo pacman -S --noconfirm --needed xdg-utils 
sudo pacman -S --noconfirm --needed xf86-input-libinput
sudo pacman -S --noconfirm --neededxf86-video-vesa 
sudo pacman -S --noconfirm --needed xfburn 
sudo pacman -S --noconfirm --needed xfce4-clipman-plugin 
sudo pacman -S --noconfirm --needed xfce4-cpufreq-plugin 
sudo pacman -S --noconfirm --needed xfce4-cpugraph-plugin 
sudo pacman -S --noconfirm --needed xfce4-notifyd 
sudo pacman -S --noconfirm --needed xfce4-power-manager 
sudo pacman -S --noconfirm --needed xfce4-pulseaudio-plugin 
sudo pacman -S --noconfirm --needed xfce4-taskmanager
sudo pacman -S --noconfirm --needed xfce4-terminal 
sudo pacman -S --noconfirm --needed xl2tpd 
sudo pacman -S --noconfirm --needed xorg-bdftopcf 
sudo pacman -S --noconfirm --needed xorg-docs 
sudo pacman -S --noconfirm --needed xorg-font-util 
sudo pacman -S --noconfirm --needed xorg-fonts-100dpi 
sudo pacman -S --noconfirm --needed xorg-fonts-75dpi 
sudo pacman -S --noconfirm --needed xorg-iceauth 
sudo pacman -S --noconfirm --needed xorg-mkfontscale 
sudo pacman -S --noconfirm --needed xorg-server 
sudo pacman -S --noconfirm --needed xorg-server-devel 
sudo pacman -S --noconfirm --needed xorg-server-xephyr 
sudo pacman -S --noconfirm --needed xorg-server-xnest 
sudo pacman -S --noconfirm --needed xorg-server-xvfb 
sudo pacman -S --noconfirm --needed xorg-sessreg 
sudo pacman -S --noconfirm --needed xorg-smproxy 
sudo pacman -S --noconfirm --needed xorg-x11perf 
sudo pacman -S --noconfirm --needed xorg-xbacklight 
sudo pacman -S --noconfirm --needed xorg-xcmsdb 
sudo pacman -S --noconfirm --needed xorg-xcursorgen 
sudo pacman -S --noconfirm --needed xorg-xdpyinfo 
sudo pacman -S --noconfirm --needed xorg-xdriinfo 
sudo pacman -S --noconfirm --needed xorg-xev 
sudo pacman -S --noconfirm --needed xorg-xgamma 
sudo pacman -S --noconfirm --needed xorg-xhost 
sudo pacman -S --noconfirm --needed xorg-xinit 
sudo pacman -S --noconfirm --needed xorg-xinput 
sudo pacman -S --noconfirm --needed xorg-xkbevd 
sudo pacman -S --noconfirm --needed xorg-xkbutils 
sudo pacman -S --noconfirm --needed xorg-xkill 
sudo pacman -S --noconfirm --needed xorg-xlsatoms 
sudo pacman -S --noconfirm --needed xorg-xlsclients 
sudo pacman -S --noconfirm --needed xorg-xpr 
sudo pacman -S --noconfirm --needed xorg-xrandr 
sudo pacman -S --noconfirm --needed xorg-xrefresh 
sudo pacman -S --noconfirm --needed xorg-xsetroot 
sudo pacman -S --noconfirm --needed xorg-xvinfo 
sudo pacman -S --noconfirm --needed xorg-xwayland 
sudo pacman -S --noconfirm --needed xorg-xwd 
sudo pacman -S --noconfirm --needed xorg-xwininfo 
sudo pacman -S --noconfirm --needed xorg-xwud 
sudo pacman -S --noconfirm --needed xsane 
sudo pacman -S --noconfirm --needed xterm 
sudo pacman -S --noconfirm --needed yay 
sudo pacman -S --noconfirm --needed zsh
sudo pacman -S --noconfirm --needed alacritty
sudo pacman -S --noconfitm --needed kitty
sudo pacman -S --noconfirm --needed pa-applet-git 

echo "enabling Ly Display Manager, if you dont like it install your own" 
systemctl enable ly
systemctl start ly

echo "rebooting system now"
systemctl reboot

