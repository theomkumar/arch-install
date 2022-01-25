#!/bin/bash
if [ "`id -u`" -ne 0 ]
then
  echo -e "\n\nRun this script as root!\n\n"
  exit -1
fi
echo -ne "
-------------------------------------------------------------------------
    Installing Xorg,Plasma,nvidia,SDDM,YAY,ZSH-pk10,KVM
-------------------------------------------------------------------------
#to speed up testing removed nvidia nvidia-utils
Installing
"
sudo pacman -S --noconfirm --needed xorg plasma konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
cd ~
yay -S zsh zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting timeshift --noconfirm --needed

yes | pacman -S sddm virt-manager qemu ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat qemu-arch-extra git openssh qbittorrent wget neofetch --needed
systemctl enable sddm
systemctl start libvirtd.service
systemctl enable libvirtd.service
virsh net-start default 
virsh net-autostart default

git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

yes | yay -S brave-bin spotify pamac-all --needed
exit
