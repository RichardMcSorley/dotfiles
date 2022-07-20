#!/bin/bash

shopt -s expand_aliases
mkdir -p ~./config/nvim/undo
# setup xcode
xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n)"
npm install -g n

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew tap homebrew/cask-fonts
brew tap corgibytes/cask-fonts


brew install \ 
  python2   \
  python3   \
  bash      \
  fortune   \
  cowsay    \
  git       \
  vcprompt  \
  alacritty \
  ranger    \
  tmux      \
  starship  \
  gradle    \
  font-mononoki-nerd-font \ 
  font-hack-nerd-font

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
