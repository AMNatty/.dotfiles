#! /usr/bin/sh
set -e

if [[ -e nvim ]]; then
    echo "Neovim not installed!"
    exit 1
fi

echo "This script is idempotent and can be run multiple times without side effects."

echo "Your existing configuration files will be overwritten!"

read -p "Do you wish to install the dotfiles? [y/N] " cont
case $cont in
    [Yy]* ) break;;
    * ) echo "Aborting."; exit 1;
esac

ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.p10k ~/.p10k.zsh

mkdir -p ~/.config/nvim
ln -sf ~/.dotfiles/init.vim ~/.config/nvim/init.vim

nvim --headless -c "PlugUpdate" -c "qall"
