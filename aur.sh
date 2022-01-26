#!/bin/bash
echo -ne "
-------------------------------------------------------------------------
    Installing AUR,PAMAC,ZSH-powerlevel10k,Timeshift,Spotify,Brave
-------------------------------------------------------------------------
 
Installing
"
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
echo -ne "
------------------------------------------------------------
                       CLEANING UP
------------------------------------------------------------
 
CLEANING
"
yay -Yc --noconfirm
pacman -Sc --noconfirm
pacman -Syu --noconfirm
exit
