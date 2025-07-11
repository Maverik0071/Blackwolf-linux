# Arch Linux Installation Script
# This script automates the installation of Arch Linux with ext4 filesystem
# WARNING: This will erase data on the target disk. Use with caution.

# Configuration - Modify these variables as needed
TARGET_DISK="/dev/sda" # Change this to your target disk
HOSTNAME="archlinux" # Set your desired hostname
TIMEZONE="UTC" # Set your timezone (e.g., "America/New_York")
LOCALE="en_US.UTF-8" # Set your locale
KEYMAP="us" # Set your keyboard layout
ROOT_PASSWORD="archlinux" # Set root password (change after installation!)
USER_NAME="user" # Set your username
USER_PASSWORD="user" # Set user password (change after installation!)

# Partition layout (modify if needed)
BOOT_PARTITION_SIZE="512M" # Size of boot partition
SWAP_SIZE="8G" # Size of swap partition (set to 0 to disable swap)

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Verify target disk exists
if [[ ! -e "$TARGET_DISK" ]]; then
    echo "Target disk $TARGET_DISK not found!"
    exit 1
fi

# Confirm before proceeding
echo "WARNING: This will erase ALL data on $TARGET_DISK!"
read -p "Are you sure you want to continue? (y/N) " confirm
if [[ "${confirm,,}" != "y" ]]; then
    echo "Installation aborted."
    exit 1
fi

# Set up partitions
echo "Partitioning $TARGET_DISK..."
parted -s "$TARGET_DISK" mklabel gpt
parted -s "$TARGET_DISK" mkpart primary fat32 1MiB "$BOOT_PARTITION_SIZE"
parted -s "$TARGET_DISK" set 1 boot on

if [[ "$SWAP_SIZE" != "0" ]]; then
    parted -s "$TARGET_DISK" mkpart primary linux-swap "$BOOT_PARTITION_SIZE" "$((BOOT_PARTITION_SIZE + SWAP_SIZE))"
    SWAP_PARTITION="${TARGET_DISK}2"
    ROOT_PARTITION="${TARGET_DISK}3"
else
    ROOT_PARTITION="${TARGET_DISK}2"
fi

parted -s "$TARGET_DISK" mkpart primary ext4 "$(if [[ "$SWAP_SIZE" != "0" ]]; then echo "$((BOOT_PARTITION_SIZE + SWAP_SIZE))"; else echo "$BOOT_PARTITION_SIZE"; fi)" 100%

# Format partitions
echo "Formatting partitions..."
mkfs.fat -F32 "${TARGET_DISK}1"

if [[ "$SWAP_SIZE" != "0" ]]; then
    mkswap "$SWAP_PARTITION"
    swapon "$SWAP_PARTITION"
fi

mkfs.ext4 "$ROOT_PARTITION"

# Mount partitions
echo "Mounting partitions..."
mount "$ROOT_PARTITION" /mnt
mkdir -p /mnt/boot
mount "${TARGET_DISK}1" /mnt/boot

# Install base system
echo "Installing base system..."
pacstrap /mnt base base-devel linux linux-firmware

# Generate fstab
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into the new system
echo "Chrooting into the new system..."
arch-chroot /mnt /bin/bash <<EOF
# Set timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# Set locale
echo "$LOCALE UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=$LOCALE" > /etc/locale.conf

# Set keyboard layout
echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf

# Set hostname
echo "$HOSTNAME" > /etc/hostname

# Configure hosts file
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

# Set root password
echo "Setting root password..."
echo "root:$ROOT_PASSWORD" | chpasswd

# Create user
echo "Creating user $USER_NAME..."
useradd -m -G wheel -s /bin/bash "$USER_NAME"
echo "$USER_NAME:$USER_PASSWORD" | chpasswd

# Configure sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Install and configure bootloader
echo "Installing bootloader..."
pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable network time synchronization
systemctl enable systemd-timesyncd.service

# Install additional packages (customize as needed)
pacman -S --noconfirm networkmanager sudo vim bash-completion
systemctl enable NetworkManager.service
EOF

# Clean up
umount -R /mnt
if [[ "$SWAP_SIZE" != "0" ]]; then
    swapoff "$SWAP_PARTITION"
fi

echo "Installation complete! You can now reboot into your new Arch Linux system."
echo "Don't forget to:"
echo "1. Change the root and user passwords"
echo "2. Configure your network if needed"
echo "3. Install additional packages as required"# Arch Linux Installation Script
# This script automates the installation of Arch Linux with ext4 filesystem
# WARNING: This will erase data on the target disk. Use with caution.

# Configuration - Modify these variables as needed
TARGET_DISK="/dev/sda" # Change this to your target disk
HOSTNAME="archlinux" # Set your desired hostname
TIMEZONE="UTC" # Set your timezone (e.g., "America/New_York")
LOCALE="en_US.UTF-8" # Set your locale
KEYMAP="us" # Set your keyboard layout
ROOT_PASSWORD="archlinux" # Set root password (change after installation!)
USER_NAME="user" # Set your username
USER_PASSWORD="user" # Set user password (change after installation!)

# Partition layout (modify if needed)
BOOT_PARTITION_SIZE="512M" # Size of boot partition
SWAP_SIZE="8G" # Size of swap partition (set to 0 to disable swap)

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Verify target disk exists
if [[ ! -e "$TARGET_DISK" ]]; then
    echo "Target disk $TARGET_DISK not found!"
    exit 1
fi

# Confirm before proceeding
echo "WARNING: This will erase ALL data on $TARGET_DISK!"
read -p "Are you sure you want to continue? (y/N) " confirm
if [[ "${confirm,,}" != "y" ]]; then
    echo "Installation aborted."
    exit 1
fi

# Set up partitions
echo "Partitioning $TARGET_DISK..."
parted -s "$TARGET_DISK" mklabel gpt
parted -s "$TARGET_DISK" mkpart primary fat32 1MiB "$BOOT_PARTITION_SIZE"
parted -s "$TARGET_DISK" set 1 boot on

if [[ "$SWAP_SIZE" != "0" ]]; then
    parted -s "$TARGET_DISK" mkpart primary linux-swap "$BOOT_PARTITION_SIZE" "$((BOOT_PARTITION_SIZE + SWAP_SIZE))"
    SWAP_PARTITION="${TARGET_DISK}2"
    ROOT_PARTITION="${TARGET_DISK}3"
else
    ROOT_PARTITION="${TARGET_DISK}2"
fi

parted -s "$TARGET_DISK" mkpart primary ext4 "$(if [[ "$SWAP_SIZE" != "0" ]]; then echo "$((BOOT_PARTITION_SIZE + SWAP_SIZE))"; else echo "$BOOT_PARTITION_SIZE"; fi)" 100%

# Format partitions
echo "Formatting partitions..."
mkfs.fat -F32 "${TARGET_DISK}1"

if [[ "$SWAP_SIZE" != "0" ]]; then
    mkswap "$SWAP_PARTITION"
    swapon "$SWAP_PARTITION"
fi

mkfs.ext4 "$ROOT_PARTITION"

# Mount partitions
echo "Mounting partitions..."
mount "$ROOT_PARTITION" /mnt
mkdir -p /mnt/boot
mount "${TARGET_DISK}1" /mnt/boot

# Install base system
echo "Installing base system..."
pacstrap /mnt base base-devel linux linux-firmware

# Generate fstab
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into the new system
echo "Chrooting into the new system..."
arch-chroot /mnt /bin/bash <<EOF
# Set timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# Set locale
echo "$LOCALE UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=$LOCALE" > /etc/locale.conf

# Set keyboard layout
echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf

# Set hostname
echo "$HOSTNAME" > /etc/hostname

# Configure hosts file
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

# Set root password
echo "Setting root password..."
echo "root:$ROOT_PASSWORD" | chpasswd

# Create user
echo "Creating user $USER_NAME..."
useradd -m -G wheel -s /bin/bash "$USER_NAME"
echo "$USER_NAME:$USER_PASSWORD" | chpasswd

# Configure sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Install and configure bootloader
echo "Installing bootloader..."
pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable network time synchronization
systemctl enable systemd-timesyncd.service

# Install additional packages (customize as needed)
pacman -S --noconfirm networkmanager sudo vim bash-completion
systemctl enable NetworkManager.service
EOF

# Clean up
umount -R /mnt
if [[ "$SWAP_SIZE" != "0" ]]; then
    swapoff "$SWAP_PARTITION"
fi

echo "Installation complete! You can now reboot into your new Arch Linux system."
echo "Don't forget to:"
echo "1. Change the root and user passwords"
echo "2. Configure your network if needed"
echo "3. Install additional packages as required"
