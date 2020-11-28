#!/bin/bash

shopt -s expand_aliases
mkdir -p ~./config/nvim/undo
# setup xcode
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew install nvm
brew install python2
brew install python3
brew install bash
brew install fortune
brew install cowsay
brew install git
brew install vcprompt
brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai
brew cask install alacritty
brew install ranger
brew install tmux
brew install starship
brew tap adoptopenjdk/openjdk
brew cask install adoptopenjdk11
brew cask install adoptopenjdk8
brew install gradle
# startup brew services
brew services start skhd
brew services start yabai

# install the scripting addition yabai
sudo yabai --install-sa
killall Dock

# install python packages
sudo easy_install pip
python3 -m pip install --user --upgrade pynvim
python2 -m pip install --user --upgrade pynvim

# setup git
git config --global core.excludesfile ~/.gitignore

# setup dotfiles
git clone --bare https://github.com/RichardMcSorley/dotfiles.git
mv dotfiles.git dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config reset HEAD
config checkout -- .

# setup bash profile
source .bash_profile

# setup nvim 
mkdir ~/.nvm
nvm install 12
nvm alias default 12

# install global npm packages
npm install -g eslint tldr

# change default sehll to new bash version
chsh -s /usr/local/bin/bash

# setup local environment
mkdir -p ~/projects

# install fonts
brew tap homebrew/cask-fonts
brew tap corgibytes/cask-fonts
brew cask install font-mononoki-nerd-eont
brew cask install font-hack-nerd-font
