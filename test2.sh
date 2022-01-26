#!/bin/bash
echo -ne "
-------------------------------------------------------------------------
    Installing GRUB,Xorg,Plasma,nvidia,SDDM,YAY,ZSH-pk10,KVM
-------------------------------------------------------------------------
#to speed up testing removed nvidia nvidia-utils 
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
echo'

127.0.0.1       localhost
::1             localhost
127.0.1.1       arch.localdomain        arch' >> /etc/hosts

#Root password
passwd
#Mirrorlist
sudo pacman -Sy 
sudo systemctl enable reflector.timer
sudo systemctl start sshd
sudo systemctl enable sshd
sudo systemctl start reflector.timer
reflector --country India,Singapore,Indonesia --age 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy base-devel linux-headers amd-ucode git nano vim reflector reflector openssh --noconfirm mtools dosfstools btrfs-progs --needed

#GRUB NETWORK SOUND BLUETOOTH PRINT
sudo pacman -S grub efibootmgr os-prober networkmanager network-manager-applet dialog xdg-utils xdg-user-dirs pipewire alsa-utils bluez bluez-utils cups --noconfirm
sudo systemctl enable NetworkManager 
sudo systemctl enable fstrim.timer
sudo systemctl enable bluetooth.service
sudo systemctl enable --now cups.service

sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --noconfirm
#Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

sudo pacman -Sy --noconfirm

#enable os prober
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo pacman -Sy --noconfirm --needed xorg plasma konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5
sudo pacman -Rdd --noconfirm iptables 
sudo pacman -S --noconfirm --needed sddm virt-manager qemu ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat qemu-arch-extra git openssh qbittorrent wget neofetch

sudo systemctl enable sddm
sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service
sudo virsh net-start default 
sudo virsh net-autostart default

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
cd ~
yay -Rdd --noconfirm archlinux-appstream-data
yay -Sdd --noconfirm snapd snapd-glib libpamac-full archlinux-appstream-data-pamac 
yay -Sdd --noconfirm --needed zsh zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting timeshift 
yay -Sdd --noconfirm brave-bin spotify 

git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
yay -S pamac-all --noconfirm
yay -Yc --noconfirm
sudo pacman -Sc --noconfirm
sudo pacman -Syu --noconfirm
exit
