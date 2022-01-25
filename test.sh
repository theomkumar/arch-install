#!/bin/bash
echo -ne "
-------------------------------------------------------------------------
    Installing Xorg,Plasma,nvidia,SDDM,YAY,ZSH-pk10,KVM
-------------------------------------------------------------------------
#to speed up testing removed nvidia nvidia-utils 
Installing
"
sudo pacman -S --noconfirm --needed xorg plasma konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5
sudo pacman -Rf iptables --noconfirm
sudo pacman -S --needed sddm virt-manager qemu ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat qemu-arch-extra git openssh qbittorrent wget neofetch

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
yay -S zsh zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting timeshift --noconfirm --needed

yay -S brave-bin spotify --noconfirm

git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
yay -S pamac-all
exit
