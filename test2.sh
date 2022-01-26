#!/bin/bash
echo -ne "
-------------------------------------------------------------------------
    Installing GRUB,Xorg,Plasma,nvidia,SDDM,KVM
-------------------------------------------------------------------------
 
Installing
"
#TIME AND LOCALE

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
nano /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf

## HOST
echo arch >> /etc/hostname
nano 
# Host addresses
echo 
'127.0.0.1       localhost
::1             localhost
127.0.1.1       arch.localdomain        arch' > /etc/hosts

#Root password
passwd
#Mirrorlist
pacman -Sy reflector openssh --noconfirm
systemctl enable reflector.timer
systemctl start sshd
systemctl enable sshd
systemctl start reflector.timer
reflector --country India,Singapore,Indonesia --age 12 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy --needed --noconfirm base-devel linux-headers amd-ucode git nano vim mtools dosfstools btrfs-progs 

#GRUB NETWORK SOUND BLUETOOTH PRINT
pacman -S grub efibootmgr os-prober networkmanager network-manager-applet dialog xdg-utils xdg-user-dirs pipewire alsa-utils bluez bluez-utils cups --noconfirm
systemctl enable NetworkManager 
systemctl enable fstrim.timer
systemctl enable bluetooth.service
systemctl enable --now cups.service

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --noconfirm
#Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

pacman -Sy --noconfirm

#enable os prober
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -Sy --noconfirm --needed xorg nvidia nvidia-utils plasma konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5
pacman -Rdd --noconfirm iptables 
pacman -S --noconfirm --needed sddm virt-manager qemu ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat qemu-arch-extra git openssh qbittorrent wget neofetch

systemctl enable sddm
systemctl start libvirtd.service
systemctl enable libvirtd.service
virsh net-start default 
virsh net-autostart default
exit
