#!/bin/bash

clear
cat fig.txt
printf "\n\n\033[01mMac OS-X Setup Script\e[0m 🔧 \n\n"
printf "This script will install various packages on the system.\n"
printf "It will also modify various OS settings.\n\n"

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

###############################################################################
#                               __ _       
#   ___  ___    ___ ___  _ __  / _(_) __ _ 
#  / _ \/ __|  / __/ _ \| '_ \| |_| |/ _` |
# | (_) \__ \ | (_| (_) | | | |  _| | (_| |
#  \___/|___/  \___\___/|_| |_|_| |_|\__, |
#                                    |___/ 
###############################################################################

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
            printf "\e[5m\e[36m==>\e[0m [SUCCESS] $action ✅ \n\n"
        else
            printf "\e[5m\e\033[91m [ERROR] $action failed ❌\n\n"
    else
        printf "\e[5m\e[36m==>\e[0m [SUCCESS] $action ✅ \n\n"
    fi
}

#enable packet filtering
printf "\nEnabling pfctl...\n"
sudo pfctl -e 

#turn on that firewall
printf "\nEnabling firewall...\n"
a=1
b="sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1"
c="sudo defaults read /Library/Preferences/com.apple.alf globalstate"

validate_config "$a" "$b" "$c"

#disable remote login
printf "\nDisabling remote login...\n"
sudo systemsetup -setremotelogin off

#disable guest login
printf "\nDisabling guest login...\n"
a=0
b="sudo defaults write /Library/Preferences/com.apple.loginwindow.plist GuestEnabled 0"
c="sudo defaults read /Library/Preferences/com.apple.loginwindow.plist GuestEnabled"

validate_config "$a" "$b" "$c"

#turn off bluetooth and restart daemon
printf "\nDisabling bluetooth...\n"
a=0
b="sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0"
c="sudo defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState"

validate_config "$a" "$b" "$c"

printf "\nStopping bluetooth daemon...\n"
sudo launchctl stop com.apple.bluetoothd
printf "Restarting bluetooth daemon...\n\n"
sudo launchctl start com.apple.bluetoothd

#require password immediately after sleep or screen saver begins
printf "\nRequire password immediately upon sleep or screen saver...\n"
a=1
b="sudo defaults write com.apple.screensaver askForPassword -int 1"
c="sudo defaults read com.apple.screensaver askForPassword"

validate_config "$a" "$b" "$c"

a=0
b="sudo defaults write com.apple.screensaver askForPasswordDelay -int 0"
c="sudo defaults read com.apple.screensaver askForPasswordDelay"

validate_config "$a" "$b" "$c"

#set display sleep to 10 mins
printf "\nSet display sleep to 10 mins...\n"
sudo pmset -a displaysleep 10

#show extensions
printf "\nShow all extensions...\n"
a=1
b="sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true"
c="sudo defaults read NSGlobalDomain AppleShowAllExtensions"

validate_config "$a" "$b" "$c"

#show status bar and path bar in finder
sudo defaults write com.apple.finder ShowStatusBar -bool true
sudo defaults write com.apple.finder ShowPathbar -bool true

#full path in title
sudo defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

#folders on top when sorting by name
sudo defaults write com.apple.finder _FXSortFoldersFirst -bool true

#prevent photos from opening automatically when devices are plugged in
sudo defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

#don't create .ds_store on usb/network drives
sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
sudo defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

#no requests for time machine on new disks
sudo defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true







