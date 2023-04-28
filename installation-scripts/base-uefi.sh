#!/bin/bash

# For this script, we are assumming the setup for your hard disk(s) is completed as follows: 
# sda
# |- sda1	/boot
# |- sda2
# 	|- root /home

# Also assumming you already did the base install, as follows:
# pacstrap /mnt base linux linux-firmware git vim intel-ucode btrfs-progs bat

# check https://www.youtube.com/watch?v=HIXnT178TgI for information reference


ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc
sed -i '171s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "arch" >> /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:root | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers pulseaudio alsa-utils xdg-user-dirs xdg-utils nfs-utils inetutils dnsutils bash-completion openssh rsync reflector acpi acpi_call ntfs-3g terminus-font firewalld gvfs gvfs-smb bluez bluez-utils cups hplip pipewire pipewire-alsa pipewire-pulse pipewire-jack tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset flatpak sof-firmware nss-mdns acpid os-prober lolcat

# You can remove the tlp package if you are installing on a desktop or vm

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

# bootctl --path=/boot install
# echo "title Arch Linux" >> /boot/loader/entries/arch.conf
#echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
#echo "initrd /vmlinuz-linux.img" >> /boot/loader/entries/arch.conf
#echo "options cryptdevice=UUID=$(blkid -s UUID -o value /dev/sda2):root root=UUID=(blkid -s UUID -o value /dev/mapper/root) rootflags=subvol=@ rw" >> /boot/loader/entries/arch.conf

#echo "title Arch Linux" >> /boot/loader/entries/arch-fallback.conf
#echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch-fallback.conf
#echo "initrd /vmlinuz-linux-fallback.img" >> /boot/loader/entries/arch-fallback.conf
#echo "options cryptdevice=UUID=$(blkid -s UUID -o value /dev/sda2):root root=UUID=(blkid -s UUID -o value /dev/mapper/root) rootflags=subvol=@ rw" >> /boot/loader/entries/arch-fallback.conf

#echo "timeout 5" >> /boot/loader/loader.conf
#echo "default arch" >> /boot/loader/loader.conf

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -m neo
echo neo:root | chpasswd
usermod -aG libvirt neo

echo "neo ALL=(ALL) ALL" >> /etc/sudoers.d/neo

exit
umount -R /mnt

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot


