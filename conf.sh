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

sudo pacman -Syu

sudo pacman -S --needed git base-devel

if ! pacman -Qs yay > /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

yay -S --needed $(cat ./pkglist)

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

ln -s $(pwd)/home/zshrc ~/.zshrc
ln -s $(pwd)/home/zshenv ~/.zshenv
ln -s $(pwd)/home/xinitrc ~/.xinitrc

echo "export DOTFILES=$(pwd)" >> ./home/zshenv
