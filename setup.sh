#!/bin/bash

function print_border {
    local string=$1
    declare -i len
    len=${#string}
    len+=4
    printf "%0.s=" $(seq 1 $len)
    printf "\n"
    printf "| \033[01m$string\e[0m |\n"
    printf "%0.s=" $(seq 1 $len)
    printf "\n"
}

function list_all {
    local list=("$@")
    for i in "${list[@]}";
        do
            printf "==> $i\n"
        done
}

function install_all {
    local list=("$@")
    local install=$2
    for i in "${list[@]}";
        do
            printf "\nInstalling $i...\n"
            $install "$i"
            printf "\e[5m\e[36m==>\e[0m $i installed. ✅ \n\n"
        done    
}

function validate_config {
    local positive=$1
    local action=$2
    local check=$3
    local config_test=$($check 2>&1)
    if [ "$config_test" != $positive ]
    then
        $($action)
        config_test=$($check 2>&1)
        if [ "$config_test" = $positive ]
        then
            printf "\n\033[01m\033[32m[SUCCESS]\e[0m \n\e[5m\e[36m==>\e[0m'$action' ✅ \n\n"
        else
            printf "\n\033[01m\e\033[91m [ERROR]\e[0m '$action' failed\e[0m ❌\n\n"
        fi
    else
        printf "\n\033[01m\033[32m[SUCCESS]\e[0m \n\e[5m\e[36m==>\e[0m'$action' ✅ \n\n"
    fi
}

clear
cat fig.txt
printf "\n"
print_border "Mac OS-X Setup Script"
printf "\n"
printf "This script will install various packages on the system. \n"
printf "It will also modify various OS settings.\n"
printf "Please refer to README.md for more information.\n\n"

read -p "Press 'CTRL+C' to quit, or any key to continue..."

###############################################################################
#  _                       
# | |__  _ __ _____      __
# | '_ \| '__/ _ \ \ /\ / /
# | |_) | | |  __/\ V  V / 
# |_.__/|_|  \___| \_/\_/ 
###############################################################################

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

printf "\nInstalling packages...\n"
install_all "${homebrew_formulae[@]}" "$(brew install)"

printf "\nInstalling casks...\n"
install_all "${homebrew_casks[@]}" "$(brew install --cask)"


brew cleanup

###############################################################################
#                               __ _       
#   ___  ___    ___ ___  _ __  / _(_) __ _ 
#  / _ \/ __|  / __/ _ \| '_ \| |_| |/ _` |
# | (_) \__ \ | (_| (_) | | | |  _| | (_| |
#  \___/|___/  \___\___/|_| |_|_| |_|\__, |
#                                    |___/ 
###############################################################################

#turn on that firewall
print_border "Enabling firewall..."
a=1
b="sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1"
c="sudo defaults read /Library/Preferences/com.apple.alf globalstate"

validate_config "$a" "$b" "$c"

#disable remote login
print_border "Disabling remote login..."
if $(sudo systemsetup -getremotelogin) | grep "On"
then
    sudo systemsetup -setremotelogin off && 
    printf "\n\033[01m\033[32m[SUCCESS]\e[0m \n\e[5m\e[36m==>\e[0m'sudo systemsetup -setremotelogin off' ✅ \n\n"
else
    printf "\n\033[01m\033[32m[SUCCESS]\e[0m \n\e[5m\e[36m==>\e[0m'Remote Login: Off' ✅ \n\n"
fi

#disable guest login
print_border "Disabling guest login..."
a=0
b="sudo defaults write /Library/Preferences/com.apple.loginwindow.plist GuestEnabled 0"
c="sudo defaults read /Library/Preferences/com.apple.loginwindow.plist GuestEnabled"

validate_config "$a" "$b" "$c"

#turn off bluetooth and restart daemon
print_border "Disabling bluetooth..."
a=0
b="sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0"
c="sudo defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState"

validate_config "$a" "$b" "$c"

printf "\nStopping bluetooth daemon...\n"
sudo launchctl stop com.apple.bluetoothd
printf "Restarting bluetooth daemon...\n\n"
sudo launchctl start com.apple.bluetoothd

#require password immediately after sleep or screen saver begins
print_border "Require password on screen saver..."
a=1
b="sudo defaults write com.apple.screensaver askForPassword -int 1"
c="sudo defaults read com.apple.screensaver askForPassword"

validate_config "$a" "$b" "$c"

print_border "Set password delay to 0..."
a=0
b="sudo defaults write com.apple.screensaver askForPasswordDelay -int 0"
c="sudo defaults read com.apple.screensaver askForPasswordDelay"

validate_config "$a" "$b" "$c"

#set display sleep to 10 mins
print_border "Set display sleep to 10 mins..."
sudo pmset -a displaysleep 10 && 
printf "\n\033[01m\033[32m[SUCCESS]\e[0m \n\e[5m\e[36m==>\e[0m'sudo pmset -a displaysleep 10' ✅ \n\n"

#show extensions
print_border "Show all file extensions..."
a=1
b="sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true"
c="sudo defaults read NSGlobalDomain AppleShowAllExtensions"

validate_config "$a" "$b" "$c"

#show status bar and path bar in finder
print_border "Show status bar and path bar in Finder..."
a=1
b="sudo defaults write com.apple.finder ShowStatusBar -bool true"
c="sudo defaults read com.apple.finder ShowStatusBar"

validate_config "$a" "$b" "$c"

a=1
b="sudo defaults write com.apple.finder ShowPathbar -bool true"
c="sudo defaults read com.apple.finder ShowPathbar"

validate_config "$a" "$b" "$c"

#full path in title
print_border "Show full POSIX path in Finder title..."
a=1
b="sudo defaults write com.apple.finder _FXShowPosixPathInTitle -bool true"
c="sudo defaults read com.apple.finder _FXShowPosixPathInTitle"

validate_config "$a" "$b" "$c"

#folders on top when sorting by name
print_border "Show folders on top when sorting by name..."
a=1
b="sudo defaults write com.apple.finder _FXSortFoldersFirst -bool true"
c="sudo defaults read com.apple.finder _FXSortFoldersFirst"

validate_config "$a" "$b" "$c"

#don't create .ds_store on usb/network drives
print_border "Don't create .DS_Store on USB drives..."
a=1
b="sudo defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true"
c="sudo defaults read com.apple.desktopservices DSDontWriteUSBStores"

validate_config "$a" "$b" "$c"

print_border "Don't create .DS_Store on network drives..."
a=1
b="sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true"
c="sudo defaults read com.apple.desktopservices DSDontWriteNetworkStores"

validate_config "$a" "$b" "$c"

#no requests for time machine on new disks
print_border "Don't request Time Machine on new disks..."
a=1
b="sudo defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true"
c="sudo defaults read com.apple.TimeMachine DoNotOfferNewDisksForBackup"

validate_config "$a" "$b" "$c"

cat done.txt