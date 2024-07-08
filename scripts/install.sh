#! /bin/bash

echo "This script will overwrite some configs. Are you sure you want to continue? (y/n)"
read response
if [ "$response" != "y" ]; then
    exit 1
fi

sudo pacman -Syu
sudo pacman -S --needed git base-devel wget stow

if ! pacman -Qs yay > /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
    yay -Y --gendb
    yay -Y --save --devel --answerclean A --answerdiff N --answeredit N --redownload
fi

mkdir ~/.config

yay -S --needed $(cat ./pkglist)

sudo chsh mkryss -s /usr/bin/zsh

rm ~/.zshrc ~/.zshenv
for conf in ../config/*; do
    rm -rf "$XDG_DESKTOP_HOME"/$(basename $conf)
    ln -sf "$DOTFILES/config/$(basename $conf)" "$XDG_CONFIG_HOME"/$(basename $conf)
done

echo "Do you also want to install the /etc files? (y/n)"
read response
if [ "$response" != "y" ]; then
    sudo cp -r ../etc/* /etc/
fi
