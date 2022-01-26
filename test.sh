#!/bin/bash
echo -ne "
-------------------------------------------------------------------------
    Installing Xorg,Plasma,nvidia,SDDM,YAY,PAMAC,ZSH-pk10,KVM
-------------------------------------------------------------------------
 
Installing
"
pacman -Sy reflector --noconfirm
sudo systemctl enable reflector.timer
sudo systemctl start reflector.timer
reflector --country India,Singapore,Indonesia --age 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy --noconfirm --needed nvidia nvidia-utils xorg plasma konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5
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
