#!/bin/bash

shopt -s expand_aliases
mkdir -p ~./config/lvim/undo ~/projects ~/.n
# setup xcode
xcode-select --install

# setup n
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n)"
npm install -g n eslint tldr

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew tap homebrew/cask-fonts
brew tap corgibytes/cask-fonts
brew tap wez/wezterm


brew install \ 
  python    \
  bash      \
  fortune   \
  cowsay    \
  git       \
  vcprompt  \
  ranger    \
  tmux      \
  starship  \
  gradle    \
  font-mononoki-nerd-font \ 
  font-hack-nerd-font

brew install --cask wez/wezterm/wezterm

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

# change default sehll to new bash version
chsh -s $(which bash)