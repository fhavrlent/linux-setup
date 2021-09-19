#!/bin/bash

echo "
    .--. 
   |o_o | 
   |:_/ | 
  //   \ \ 
 (|     | ) 
/'\_   _/'\ 
\___)=(___/ 
"

sudo mint-switch-to-local-mirror

## Enable snap store, update, upgrade
sudo rm /etc/apt/preferences.d/nosnap.pref
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

ln -s /var/lib/snapd/desktop/applications/ ~/.local/share/applications/snap

sudo apt update
sudo apt upgrade -y

#################################

apt_tools=(
  "python3-dev"
  "python3-pip"
  "python3-setuptools"
  "apt-transport-https"
  "ruby"
  "snapd"
  "git"
)

pip_packages=(
  "thefuck"
)

gem_packages=(
  "lolcat"
)

apt_packages=(
  "tig"
  "zsh"
  "fonts-firacode"
  "steam"
  "code"
  "tilix"
  "vlc"
)

snap_packages=(
  "todoist"
)

npm_packages=(
  "yarn"
)

#################################

## Download and install fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
cd ~

## Install Discord
wget https://dl.discordapp.net/apps/linux/0.0.15/discord-0.0.15.deb
sudo apt install ./discord-0.0.15.deb -y
rm -f ./discord-0.0.15.deb

## Install Keybase

curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb -y
rm -f ./keybase_amd64.deb

## Install packages

for apt_tool in "${apt_tools[@]}"; do
  sudo apt install "$apt_tool" -y
done

for apt_package in "${apt_packages[@]}"; do
  sudo apt install "$apt_package" -y
done

for gem_package in "${gem_packages[@]}"; do
  sudo gem install "$gem_package"
done

for pip_package in "${pip_packages[@]}"; do
  sudo pip3 install "$pip_package"
done

for snap_package in "${snap_packages[@]}"; do
  sudo snap install "$snap_package"
done

## Install nvm, node and yarn

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install --lts

for npm_package in "${npm_packages[@]}"; do
  npm i "$npm_package" -g
done

## Install zsh and oh-my-zsh

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

## Dotfiles
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply fhavrlent

## Tilix configuration

sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh

dconf load /com/gexperts/Tilix/ <tilix.dconf

## ZSH
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

source .zshrc

## Done

sudo reboot
