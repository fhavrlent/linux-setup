#!/bin/bash

echo "
██████████████████  ████████
██████████████████  ████████
██████████████████  ████████
██████████████████  ████████
████████            ████████
████████  ████████  ████████
████████  ████████  ████████
████████  ████████  ████████
████████  ████████  ████████
████████  ████████  ████████
████████  ████████  ████████
████████  ████████  ████████
████████  ████████  ████████
████████  ████████  ████████
"

pacman_packages=(
    "chezmoi"
    "chromium"
    "discord"
    "keychain"
    "libreoffice-fresh"
    "lolcat"
    "manjaro-zsh-config"
    "neofetch"
    "noto-fonts-emoji"
    "nvm"
    "python-pip"
    "thefuck"
    "tig"
    "tilix"
    "ttf-fira-code"
    "zsh-autosuggestions"
    "zsh-completions"
    "zsh-history-substring-search"
    "zsh-syntax-highlighting"
    "zsh-theme-powerlevel10k"
    "zsh"
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

to_uninstall=(
    "onlyoffice-desktopeditors"
)

echo "Uninstall packages"
for package in "${to_uninstall[@]}"; do
    sudo pacman -R --noconfirm "$package"
done

echo "Update system"
sudo pacman --noconfirm -Syyu

##############
echo "Install yay"
sudo pacman -S --needed --noconfirm git base-devel yay
##############

echo "Install Pacman packages"
for pacman_package in "${pacman_packages[@]}"; do
    sudo pacman -S --noconfirm "$pacman_package"
done

echo "Install AUR packages"
for aur_package in "${aur_packages[@]}"; do
    yay -S --noconfirm "$aur_package"
done

echo "Install pip packages"
for pip_package in "${pip_packages[@]}"; do
    pip3 install "$pip_package"
done


##############
echo "Dotfiles"
mkdir ~/.config/chezmoi -p
cd ~/.config/chezmoi
wget https://raw.githubusercontent.com/fhavrlent/linux-setup/main/chezmoi.toml
cd ~
chezmoi init --apply --verbose fhavrlent
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
echo "Set Node"
. ~/.nvm/nvm.sh
nvm install node
##############

echo "Install npm packages"
for npm_package in "${npm_packages[@]}"; do
    npm i "$npm_package" -g
done


##############
echo "Mullvad GPG key"
wget https://mullvad.net/media/mullvad-code-signing.asc
gpg2 --import mullvad-code-signing.asc
rm mullvad-code-signing.asc
##############


echo "Import GPG Private key"
cd ~/.gpg
gpg --batch --import privkey.asc
(echo 5; echo y; echo save) |
gpg --command-fd 0 --no-tty --no-greeting -q --edit-key "$(
  gpg --list-packets <privkey.asc |
awk '$1=="keyid:"{print$2;exit}')" trust
cd ~

chsh -s $(which zsh)