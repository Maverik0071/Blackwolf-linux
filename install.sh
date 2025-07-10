#!/bin/bash

# Arch Linux Automated Installer
# WARNING: This will erase the target disk! Use at your own risk.

# Configuration - customize these variables
TARGET_DISK="/dev/sda" # Disk to install to
HOSTNAME="archlinux" # System hostname
USERNAME="user" # Main user to create
TIMEZONE="America/New_York" # Timezone (see /usr/share/zoneinfo)
KEYMAP="us" # Keyboard layout
LANG="en_US.UTF-8" # System language
INSTALL_DRIVE="nvme" # 'nvme' or 'sata' (for bootloader)
ENABLE_ENCRYPTION=false # Set to true for encrypted disk
ENCRYPTION_PASSWORD="" # Leave empty to be prompted

# Custom package lists
BASE_PACKAGES=(
base linux linux-firmware
btrfs-progs dosfstools exfatprogs f2fs-tools e2fsprogs ntfs-3g
man-db man-pages texinfo
networkmanager git openssh sudo
)

DESKTOP_PACKAGES=(
xorg-server xorg-xinit xorg-xrandr xorg-xsetroot
lightdm lightdm-gtk-greeter
alacritty firefox
noto-fonts noto-fonts-emoji
)

# -----------------------------------------------------------
# DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU'RE DOING
# -----------------------------------------------------------

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
echo "This script must be run as root!"
exit 1
fi

# Verify internet connection
if ! ping -c 1 archlinux.org &> /dev/null; then
echo "No internet connection detected!"
echo "Please connect to the internet before running this script."
exit 1
fi

# Confirm installation
echo "WARNING: This will erase ALL DATA on ${TARGET_DISK}!"
read -p "Are you sure you want to continue? (y/N) " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
echo "Installation cancelled."
exit 0
fi

# Set up disk
echo "Partitioning disk..."
if [ "$INSTALL_DRIVE" = "nvme" ]; then
BOOT_PARTITION="${TARGET_DISK}p1"
ROOT_PARTITION="${TARGET_DISK}p2"
else
BOOT_PARTITION="${TARGET_DISK}1"
ROOT_PARTITION="${TARGET_DISK}2"
fi

# Partition the disk
parted -s "$TARGET_DISK" mklabel gpt
parted -s "$TARGET_DISK" mkpart primary fat32 1MiB 513MiB
parted -s "$TARGET_DISK" set 1 boot on
parted -s "$TARGET_DISK" mkpart primary btrfs 513MiB 100%

# Format partitions
echo "Formatting partitions..."
mkfs.fat -F32 "$BOOT_PARTITION"

if [ "$ENABLE_ENCRYPTION" = true ]; then
if [ -z "$ENCRYPTION_PASSWORD" ]; then
read -sp "Enter encryption password: " ENCRYPTION_PASSWORD
echo
fi

echo "Setting up encryption..."
echo -n "$ENCRYPTION_PASSWORD" | cryptsetup -q luksFormat "$ROOT_PARTITION" -
echo -n "$ENCRYPTION_PASSWORD" | cryptsetup open "$ROOT_PARTITION" cryptroot -
mkfs.btrfs -f /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt
else
mkfs.btrfs -f "$ROOT_PARTITION"
mount "$ROOT_PARTITION" /mnt
fi

# Create subvolumes
echo "Creating BTRFS subvolumes..."
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@var_log
umount /mnt

# Mount the subvolumes
mount -o noatime,compress=zstd,space_cache=v2,subvol=@ "$ROOT_PARTITION" /mnt
mkdir -p /mnt/{boot,home,.snapshots,var/log}
mount "$BOOT_PARTITION" /mnt/boot
mount -o noatime,compress=zstd,space_cache=v2,subvol=@home "$ROOT_PARTITION" /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,subvol=@snapshots "$ROOT_PARTITION" /mnt/.snapshots
mount -o noatime,compress=zstd,space_cache=v2,subvol=@var_log "$ROOT_PARTITION" /mnt/var/log

# Install base system
echo "Installing base system..."
pacstrap /mnt "${BASE_PACKAGES[@]}"

# Generate fstab
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into the new system
echo "Configuring the new system..."
arch-chroot /mnt /bin/bash <<EOF
# Set timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# Localization
echo "LANG=$LANG" > /etc/locale.conf
echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf
sed -i "s/^#\($LANG\)/\1/" /etc/locale.gen
locale-gen

# Network configuration
echo "$HOSTNAME" > /etc/hostname
cat > /etc/hosts <<HOSTS
127.0.0.1 localhost
::1 localhost
127.0.1.1 $HOSTNAME.localdomain $HOSTNAME
HOSTS

# Create user
useradd -m -G wheel -s /bin/bash "$USERNAME"
echo "Set password for $USERNAME:"
passwd "$USERNAME"
echo "Set password for root:"
passwd

# Enable sudo for wheel group
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Install additional packages
echo "Installing additional packages..."
pacman -S --noconfirm "${DESKTOP_PACKAGES[@]}"

# Enable services
systemctl enable NetworkManager
systemctl enable lightdm

# Install bootloader
echo "Installing bootloader..."
bootctl install

# Create bootloader config
cat > /boot/loader/loader.conf <<LOADER
default arch
timeout 3
editor no
LOADER

# Create boot entry
if [ "$ENABLE_ENCRYPTION" = true ]; then
root_uuid=\$(blkid -s UUID -o value "$ROOT_PARTITION")
cat > /boot/loader/entries/arch.conf <<ENTRY
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=UUID=\$root_uuid:cryptroot root=/dev/mapper/cryptroot rw
ENTRY
else
root_uuid=\$(blkid -s UUID -o value "$ROOT_PARTITION")
cat > /boot/loader/entries/arch.conf <<ENTRY
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=UUID=\$root_uuid rw
ENTRY
fi
EOF

echo "Installation complete!"
echo "You can now reboot into your new Arch Linux system."
echo "Don't forget to remove the installation media!"
