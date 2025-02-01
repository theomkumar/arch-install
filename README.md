## PREP- mirrorlist/clock/SSH
```
System Clock Update
# timedatectl set-ntp true
# pacman -Syy reflector

Update Mirrorlist
# reflector --country India,Singapore,Indonesia --age 12 --sort rate --save /etc/pacman.d/mirrorlist

SSH(optional)
# pacman -Syy openssh
# systemctl start sshd
# Passwd
# ip a
# ssh root@192....

if key change error, clear cache
SSH Remove ssh cache :-
# ssh-keygen -R 192.168....
```

## Partition/Format/Mount (EXT4)
```
# lsblk
NAME  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0   7:0    0 715.4M  1 loop /run/archiso/airootfs
sda     8:0    0    50G  0 disk
sr0    11:0    1 864.3M  0 rom  /run/archiso/bootmnt

# gdisk /dev/sda
GPT fdisk (gdisk) version 1.0.8

Partition table scan:
  MBR: not present
  BSD: not present
  APM: not present
  GPT: not present

Creating new GPT entries in memory.

Command (? for help): n
Partition number (1-128, default 1):
First sector (34-104857566, default = 2048) or {+-}size{KMGTP}:
Last sector (2048-104857566, default = 104857566) or {+-}size{KMGTP}: +300M
Current type is 8300 (Linux filesystem)
Hex code or GUID (L to show codes, Enter = 8300): ef00
Changed type of partition to 'EFI system partition'

Command (? for help): n
Partition number (2-128, default 2):
First sector (34-104857566, default = 616448) or {+-}size{KMGTP}:
Last sector (616448-104857566, default = 104857566) or {+-}size{KMGTP}: +4G
Current type is 8300 (Linux filesystem)
Hex code or GUID (L to show codes, Enter = 8300): 8200
Changed type of partition to 'Linux swap'

Command (? for help): n
Partition number (3-128, default 3):
First sector (34-104857566, default = 9005056) or {+-}size{KMGTP}:
Last sector (9005056-104857566, default = 104857566) or {+-}size{KMGTP}: +30G
Current type is 8300 (Linux filesystem)
Hex code or GUID (L to show codes, Enter = 8300):
Changed type of partition to 'Linux filesystem'

Command (? for help): n
Partition number (4-128, default 4):
First sector (34-104857566, default = 71919616) or {+-}size{KMGTP}:
Last sector (71919616-104857566, default = 104857566) or {+-}size{KMGTP}:
Current type is 8300 (Linux filesystem)
Hex code or GUID (L to show codes, Enter = 8300):
Changed type of partition to 'Linux filesystem'

Command (? for help): w

Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
PARTITIONS!!

Do you want to proceed? (Y/N): Y
OK; writing new GUID partition table (GPT) to /dev/sda.
The operation has completed successfully.

# lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0 715.4M  1 loop /run/archiso/airootfs
sda      8:0    0    50G  0 disk
├─sda1   8:1    0   300M  0 part
├─sda2   8:2    0     4G  0 part
├─sda3   8:3    0    30G  0 part
└─sda4   8:4    0  15.7G  0 part
sr0     11:0    1 864.3M  0 rom  /run/archiso/bootmnt

Format
# mkfs.fat -F32 /dev/sda1

# mkswap /dev/sda2

# mkfs.ext4 /dev/sda3

# mkfs.ext4 /dev/sda4

Mount
# mount /dev/sda3 /mnt
# mkdir -p /mnt/{boot/efi,home}
# mount /dev/sda1 /mnt/boot/efi
# mount /dev/sda4 /mnt/home
# swapon /dev/sda2

# lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0 715.4M  1 loop /run/archiso/airootfs
sda      8:0    0    50G  0 disk
├─sda1   8:1    0   300M  0 part /mnt/boot/efi
├─sda2   8:2    0     4G  0 part [SWAP]
├─sda3   8:3    0    30G  0 part /mnt
└─sda4   8:4    0  15.7G  0 part /mnt/home
sr0     11:0    1 864.3M  0 rom  /run/archiso/bootmnt
```

## Partition/format/mount(BTRFS):-
```
# lsblk
NAME  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0   7:0    0 715.4M  1 loop /run/archiso/airootfs
sr0    11:0    1 864.3M  0 rom  /run/archiso/bootmnt
vda   254:0    0    50G  0 disk  
root@archiso ~ # gdisk /dev/vda
GPT fdisk (gdisk) version 1.0.8

Partition table scan:
 MBR: not present
 BSD: not present
 APM: not present
 GPT: not present

Creating new GPT entries in memory.

Command (? for help): n
Partition number (1-128, default 1):  
First sector (34-104857566, default = 2048) or {+-}size{KMGTP}:  
Last sector (2048-104857566, default = 104857566) or {+-}size{KMG
TP}: +300M
Current type is 8300 (Linux filesystem)
Hex code or GUID (L to show codes, Enter = 8300): ef00
Changed type of partition to 'EFI system partition'

Command (? for help): n
Partition number (2-128, default 2):  
First sector (34-104857566, default = 616448) or {+-}size{KMGTP}:
 
Last sector (616448-104857566, default = 104857566) or {+-}size{K
MGTP}:  
Current type is 8300 (Linux filesystem)
Hex code or GUID (L to show codes, Enter = 8300):  
Changed type of partition to 'Linux filesystem'

Command (? for help): w

Final checks complete. About to write GPT data. THIS WILL OVERWRI
TE EXISTING
PARTITIONS!!

Do you want to proceed? (Y/N): y
OK; writing new GUID partition table (GPT) to /dev/vda.
The operation has completed successfully.

# lsblk              
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0 715.4M  1 loop /run/archiso/airootfs
sr0     11:0    1 864.3M  0 rom  /run/archiso/bootmnt
vda    254:0    0    50G  0 disk  
├─vda1 254:1    0   300M  0 part  
└─vda2 254:2    0  49.7G  0 part  

Format

# mkfs.vfat /dev/vda1
# mkfs.btrfs /dev/vda2
     
Create & Mount subvolume
# mount /dev/vda2 /mnt

# btrfs subvolume create /mnt/@

# btrfs subvolume create /mnt/@home

# btrfs subvolume create /mnt/@var  


# umount /mnt

# mount -o noatime,compress=zstd,ssd,discard=async
,space_cache=v2,subvol=@ /dev/vda2 /mnt

# mkdir -p /mnt/{boot/efi,home,var}

# mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@home /dev/vda2 /mnt/home
# mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@var /dev/vda2 /mnt/var   
# mount /dev/vda1 /mnt/boot/efi

# lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0 715.4M  1 loop /run/archiso/airootfs
sr0     11:0    1 864.3M  0 rom  /run/archiso/bootmnt
vda    254:0    0    50G  0 disk  
├─vda1 254:1    0   300M  0 part /mnt/boot/efi
└─vda2 254:2    0  49.7G  0 part /mnt/var
                                /mnt/home
                                /mnt
```

## ARCH BASE INSTALLATION/GENERATE FSTAB
```
EXT4
# pacstrap /mnt base base-devel linux linux-firmware linux-headers amd-ucode nano vim reflector mtools dosfstools

BTRFS
# pacstrap /mnt base base-devel linux linux-firmware linux-headers amd-ucode git nano vim reflector mtools dosfstools btrfs-progs

FSTAB GENERATE
# genfstab -U /mnt >> /mnt/etc/fstab

# arch-chroot /mnt
[root@archiso /]#
```
## TIME AND LOCALE
```
# ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
# hwclock --systohc

Uncomment required locale:-
# nano /etc/locale.gen

# locale-gen
# echo LANG=en_US.UTF-8 >> /etc/locale.conf
```
## HOST
```
# echo arch >> /etc/hostname
Edit: 
# nano /etc/hosts
 # See hosts(5) for details.
127.0.0.1       localhost
::1             localhost
127.0.1.1       arch.localdomain        arch

Root password
# passwd
```
## Bootloader/Sound/Network/Bluetooth/Printer
```
# pacman -S grub efibootmgr os-prober networkmanager network-manager-applet dialog xdg-utils xdg-user-dirs pipewire alsa-utils bluez bluez-utils cups

# systemctl enable NetworkManager 
# systemctl enable fstrim.timer
# systemctl enable bluetooth.service
# systemctl enable --now cups.service

Bootloader 
# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg

Enable os-prober
# nano /etc/default/grub

Uncomment or add this line at the end
GRUB_DISABLE_OS_PROBER=false
# grub-mkconfig -o /boot/grub/grub.cfg
```

## USER ADD 
```
# useradd -m omi
# passwd omi
APPEND supplementary group for the user 
# usermod -aG wheel omi
# EDITOR=nano visudo
Uncomment 
%wheel All=(ALL) ALL

(only btrfs)(ext4 skip)
# nano /etc/mkinitcpio.conf
   Modules=(btrfs)
# mkinitcpio -p linux

Exit arch-chroot unmount & Reboot
# exit
# umount -R /mnt

REBOOT

BASIC INSTALLATION DONE
``` 

## POST-INSTALL SETUP:-
```
Enable Multilib to run 32bit-app(optional):-

# nano /etc/pacman.conf 
Uncomment the below two lines:-
#[multilib] 
#Include = /etc/pacman.d/mirrorlist MESA Libraries (32bit) 
```

## Xorg/graphics driver (for amd gpu xf86-video-amdgpu)
```
# sudo pacman -S xorg nvidia nvidia-utils
```

## KDE Plasma
```
# sudo pacman -S plasma konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5

# sudo pacman -S sddm 
# sudo systemctl enable sddm
```

## YAY
```
# git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
## My Packages KVM/ZSH/Brave/Spotify/Pamac/ZSH-Theme(Powerlevel10k)
```
# yay -S brave-bin spotify pamac-all timeshift
# sudo pacman -S virt-manager qemu ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat qemu-arch-extra git openssh qbittorrent wget neofetch

# sudo systemctl start libvirtd.service
# sudo systemctl enable libvirtd.service
# sudo systemctl enable sshd.service
# sudo virsh net-start default 
# sudo virsh net-autostart default

ZSH(optional)

Installation with few plugins
# sudo pacman -S zsh zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting

# git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# chsh $USER
New shell :/bin/zsh
In konsole settings>edit current profile>General>command:/bin/zsh
Restart Konsole
```

CURRENT SETUP:
```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    0 931.5G  0 disk 
├─sda1        8:1    0 813.3G  0 part 
└─sda2        8:2    0 118.2G  0 part 
sdb           8:16   1 114.6G  0 disk 
├─sdb1        8:17   1 114.6G  0 part 
└─sdb2        8:18   1    32M  0 part 
zram0       254:0    0     4G  0 disk [SWAP]
nvme1n1     259:0    0 238.5G  0 disk 
├─nvme1n1p1 259:1    0   511M  0 part /boot
└─nvme1n1p2 259:2    0   238G  0 part /var/lib/docker/btrfs
                                      /var/log
                                      /var/cache/pacman/pkg
                                      /home
                                      /.snapshots
                                      /
nvme0n1     259:3    0 931.5G  0 disk 
├─nvme0n1p1 259:4    0   100M  0 part 
├─nvme0n1p2 259:5    0    16M  0 part 
├─nvme0n1p3 259:6    0   120G  0 part 
├─nvme0n1p4 259:7    0 810.8G  0 part 
└─nvme0n1p5 259:8    0   604M  0 part 

```
## Fix Common Startup Issues
```
BOOT INTO ARCH LIVE MEDIA
# setfont -d

# sudo mount /dev/nvme0n1p2 /mnt -o subvol=@

# sudo mount /dev/nvme0n1p1 /mnt/boot

# genfstab -U /mnt >> /mnt/etc/fstab

# arch-chroot /mnt

# sudo pacman -S base base-devel linux linux-firmware linux-headers amd-ucode mtools dosfstools btrfs-progs

# sudo mkinitcpio -P linux

# exit
```
## REBOOT :)

--------------


## FSTAB ISSUE / Cloning into new drive
```
# IF size mismatch

> btrfs rescue fix-device-size /dev/sdb2

> mount -o subvol=@ /dev/sdb2 /mnt
> mount -a
> genfstab -U /mnt > /mnt/etc/fstab
```

## Fix Wifi turning off automatically

```


❯ nmcli con show

NAME                UUID                                  TYPE   
   DEVICE 

Name 4G     wifi   
 .......

❯ nmcli con show "Name 4G" | grep save


802-11-wireless.powersave:              0 (default)

❯ nmcli connection modify "Name 4G" 802-11-wireless.powersave 2

❯ nmcli connection up "Name 4G"

Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/21)

❯ nmcli con show "Name 4G" | grep save


802-11-wireless.powersave:              2 (disable)


❯ echo -e "[connection]\nwifi.powersave = 2" | sudo tee /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf > /dev/null



```
## IF THE WIFI ISSUE STILL PERSISTS::
```


❯ ip link show

6: wlp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DORMANT group default qlen 1000
  

❯ sudo iw dev wlp3s0 set power_save off

❯ echo 'options rtw88_pci disable_aspm=1' | sudo tee /etc/modprobe.d/rtw88_pci.conf

options rtw88_pci disable_aspm=1

❯ sudo modprobe -r rtw88_8822ce && sudo modprobe rtw88_8822ce

❯ echo 'options rtw88_core disable_lps_deep=Y' | sudo tee -a /etc/modprobe.d/rtw88_core.conf

options rtw88_core disable_lps_deep=Y

```
