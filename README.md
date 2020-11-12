# dotfiles

Setup your new mac:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/RichardMcSorley/dotfiles/mac/init.sh)"
```

Setup git directory:

```bash
git clone --bare https://github.com/RichardMcSorley/dotfiles.git
mv dotfiles.git dotfiles
# add an alias in your bashrc or bash_profile
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
source .bash_profile
config config --local status.showUntrackedFiles no # dont track all the files
```

Usage example:

```bash
config checkout -b ubuntu
config add .bashrc
config commit -m "Added bashrc file"
config push origin ubuntu
```

Pulling a single file

```bash
config status # lists files
config reset HEAD .bashrc
config checkout -- .bashrc
```
