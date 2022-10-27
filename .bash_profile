export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH=/usr/local/bin:$PATH
export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:$(brew --prefix)/opt/python/bin
export PATH=${PATH}:${HOME}/.local/bin/

export N_PREFIX="$HOME/.n"
export N_PRESERVE_NPM=1
export PATH=${PATH}:${N_PREFIX}/bin

[ -f ~/.company.bash ] && source ~/.company.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"

alias vim=lvim
alias nvim=lvim
alias watch='watch '
alias ls='ls -GFh'
alias edit-bash='lvim ~/.bash_profile'
alias update-bash='. ~/.bash_profile'
alias chromes='open /Applications/Google\ Chrome.app --args --remote-debugging-port=9222 --disable-web-security --user-data-dir'
alias dc="docker-compose"
alias d="docker"
alias k=kubectl
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl get --ignore-not-found ${i}
  done
}

dcleanup(){
	docker system prune -a
}

dotenv(){
	export $(cat $PWD/.env)
}

eval "$(starship init bash)"

newssh(){
  echo "type your email"
  read email
  echo "type your keyname"
  read keyname
	yes | ssh-keygen -t ed25519 -N "" -C "$email" -f ~/.ssh/$keyname
	cat ~/.ssh/$keyname.pub | pbcopy
}

ide(){
  TOP=$(wezterm cli split-pane --bottom --top-level --percent 30)
  LEFT=$(wezterm cli split-pane --right --percent 66 --pane-id $TOP)
  RIGHT=$(wezterm cli split-pane --right --percent 50 --pane-id $LEFT)
}
