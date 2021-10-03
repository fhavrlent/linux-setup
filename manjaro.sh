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

sudo pacman -Syyu

pacman_packages=(
    "chezmoi"
    "chromium"
    "discord"
    "keychain"
    "libreoffice-fresh"
    "lolcat"
    "neofetch"
    "nvm"
    "thefuck"
    "tig"
    "ttf-fira-code"
)

aur_packages=(
    "keybase-bin"
    "mullvad-vpn-bin"
    "todoist-appimage"
    "visual-studio-code-bin"
)

pip_packages=(
    "random_username"
)

npm_packages=(
    "yarn"
)

##############
echo "Dotfiles"
chezmoi init --apply --verbose fhavlent
##############

##############
echo "Fonts"
sudo mkdir -p /usr/local/share/fonts/m/
cd /usr/local/share/fonts/m/
sudo wget https://github.com/fhavrlent/powerline-fonts/raw/main/MesloLGS_NF_Bold.ttf
sudo wget https://github.com/fhavrlent/powerline-fonts/raw/main/MesloLGS_NF_Bold_Italic.ttf
sudo wget https://github.com/fhavrlent/powerline-fonts/raw/main/MesloLGS_NF_Italic.ttf
sudo wget https://github.com/fhavrlent/powerline-fonts/raw/main/MesloLGS_NF_Regular.ttf
cd ~
##############

##############
echo "Install yay"
sudo pacman -S --needed --noconfirm git base-devel yay
##############

##############
echo "Set Node"
nvm install node
##############

##############
echo "Mullvad GPG key"
wget https://mullvad.net/media/mullvad-code-signing.asc
gpg2 --import mullvad-code-signing.asc
rm mullvad-code-signing.asc
##############

echo "Install Pacman packages"
for pacman_package in "${pacman_packages[@]}"; do
    sudo pacman -S --noconfirm "$pacman_package"
done

echo "Install AUR packages"
for aur_package in "${aur_packages[@]}"; do
    yay -S --noconfirm "$aur_package"
done

echo "Install npm packages"
for npm_package in "${npm_packages[@]}"; do
    npm i "$npm_package" -g
done

echo "Install pip packages"
for pip_package in "${pip_packages[@]}"; do
    pip3 install "$pip_package"
done

echo "Import GPG Private key"
cd ~/.gpg
gpg --batch --import privkey.asc
(echo 5; echo y; echo save) |
gpg --command-fd 0 --no-tty --no-greeting -q --edit-key "$(
  gpg --list-packets <privkey.asc |
awk '$1=="keyid:"{print$2;exit}')" trust
cd ~

source .zshrc