#!/bin/bash
echo -ne "
-------------------------------------------------------------------------
    Installing Xorg,Plasma,nvidia,SDDM,YAY,ZSH-pk10,KVM
-------------------------------------------------------------------------

Installing"

sudo pacman -S --noconfirm --needed xorg nvidia nvidia-utils plasma konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5 sddm virt-manager qemu ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat qemu-arch-extra git openssh qbittorrent wget neofetch -y 

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
cd ~
yay -S zsh zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting brave-bin spotify pamac-all timeshift -y --noconfirm  

sudo systemctl enable sddm
sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service
sudo virsh net-start default 
sudo virsh net-autostart default

git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

exit
