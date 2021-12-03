#!/bin/bash

clear
cat fig.txt
printf "OSX Setup Script\n\n"
printf "This script will install various packages on your system.\n\n"
read -p "Press 'CTRL+C' to quit, or any key to continue..."

printf "Checking for Homebrew 🍺 installation...\n"

while ! command -v brew &> /dev/null
do
    printf "==> Homebrew not installed. ❌\n\n"
    printf "Installing Homebrew 🍺...\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
done

if command -v brew &> /dev/null
then
    printf "\e[5m\e[36m==>\e[0m Homebrew installed. ✅ \n\n"
fi

printf "Disabling Homebrew analytics...\n"
brew analytics off
brew analytics state

brew update

homebrew_formulae=(
    "git"
    "wget"
    "python"
    "pylint"
    "figlet"
    "magic-wormhole"
    "ffmpeg"
    "imagemagick"
    "cowsay"
    "irssi"
    "sqlcipher"
    "sqlite"
    "sl"
)

printf "\nInstalling packages...\n"
for formula in "${homebrew_formulae[@]}"
do
    printf "==> $formula\n"
done

for formula in "${homebrew_formulae[@]}"
do
    printf "\nInstalling $formula...\n"
    brew install "$formula"
    printf "\e[5m\e[36m==>\e[0m $formula installed. ✅ \n\n"
done

figlet ~success~

homebrew_casks=(
    "little-snitch"
    "firefox"
    "gimp"
    "libreoffice"
    "adium"
    "macfuse"
    "veracrypt"
    "signal"
    "visual-studio-code"
)

printf "\nInstalling casks...\n"
for cask in "${homebrew_casks[@]}"
do
    printf "==> $cask\n"
done

for cask in "${homebrew_casks[@]}"
do
    printf "\nInstalling $cask...\n"
    brew install --cask "$cask"
    printf "\e[5m\e[36m==>\e[0m $cask installed. ✅ \n\n"

done

brew cleanup
