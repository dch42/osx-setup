#!/bin/bash

clear
printf "OSX Setup Script\n\n"
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
    "python"
    "figlet"
    "magic-wormhole"
    "ffmpeg"
    "imagemagick"
    "cowsay"
    "sqlcipher"
    "sqlite"
    "sl"
)

printf "\nInstalling packages...\n"
for formulae in "${homebrew_formulae[@]}"
do
    printf "==> $formulae\n"
done

for formulae in "${homebrew_formulae[@]}"
do
    printf "\nInstalling $formulae...\n"
    brew install "$formulae"
done

figlet ~success~

