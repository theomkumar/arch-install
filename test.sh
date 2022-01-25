#!/usr/bin/env bash
echo -ne "
-------------------------------------------------------------------------
                    My Packages
-------------------------------------------------------------------------

Installing

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm

pacman -S xorg nvidia nvidia-utils plasma konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5 sddm

systemctl enable sddm

yay -S zsh zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting brave-bin spotify pamac-all timeshift --noconfirm

pacman -S virt-manager qemu ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat qemu-arch-extra git openssh qbittorrent wget neofetch

cd ~
touch "~/.cache/zshhistory"
git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
"
exit
