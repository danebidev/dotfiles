#! /usr/bin/bash

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

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

rm ~/.zshrc ~/.zshenv ~/.zshrc.pre-oh-my-zsh
stow --dotfiles -t ~ --adopt eww hypr nvim xorg zsh
