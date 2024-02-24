#! /usr/bin/bash

echo "This script will overwrite some configs. Are you sure you want to continue? (y/n)"
read response
if [ "$response" != "y" ]; then
    exit 1
fi

mkdir ~/.config

for folder in $(ls ./config); do
    rm -rf ~/.config/$folder
done

for folder in $(ls ./config); do
    ln -s $(pwd)/config/$folder ~/.config/$folder
done

for folder in $(ls ./etc); do
    sudo rm -rf /etc/$folder
done

for folder in $(ls ./etc); do
    sudo cp -r $(pwd)/etc/$folder /etc/$folder
done

sudo pacman -S git base-devel

if pacman -Q yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

yay -S $(cat ./pkglist)

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

cp ./home/zshrc ~/.zshrc
cp ./home/xinitrc ~/.xinitrc
