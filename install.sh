#! /usr/bin/sh
set -e

echo -n "Checking for Zsh: "
if ! (command -v zsh); then
    echo "Neovim not installed!"
    exit 1
fi

echo -n "Checking for Neovim: "
if ! (command -v nvim); then
    echo "Zsh is not installed!"
    exit 1
fi

echo ""

echo "This script is idempotent and can be run multiple times without side effects."

echo "Your existing configuration files will be overwritten!"

read -p "Do you wish to install the dotfiles? [y/N] " cont
case $cont in
    [Yy]* ) break;;
    * ) echo "Aborting."; exit 1;
esac

echo ""

echo "Creating symlink: ~/.zshrc -> ~/.dotfiles/.zshrc"
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
echo "Creating symlink: ~/.p10k.zsh -> ~/.dotfiles/.p10k"
ln -sf ~/.dotfiles/.p10k.zsh ~/.p10k.zsh

mkdir -p ~/.config/nvim
echo "Creating symlink: ~/.config/nvim/init.vim -> ~/.dotfiles/init.vim"
ln -sf ~/.dotfiles/init.vim ~/.config/nvim/init.vim

echo ""
echo "Updating Neovim plugins..."

nvim --headless -c "PlugUpdate" -c "qall"

echo "Done"
