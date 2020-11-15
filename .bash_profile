export BASH_SILENCE_DEPRECATION_WARNING=1
export NVM_DIR=~/.nvm
export PATH=/usr/local/opt/llvm/bin:$PATH
export PATH=/usr/local/bin:$PATH
export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib
export DOCKER_REPO_PREFIX=hub.docker.prod.walmart.com
export PATH=${PATH}:${M2_HOME}/bin
export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:${HOME}/Library/Python/2.7/bin
export PATH=${PATH}:${HOME}/Library/Python/3.7/bin

[ -f ~/.company.bash ] && source ~/.company.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export ANDROID_SDK=/Users/r0m00n5/Library/Android/sdk

alias watch='watch '
alias ls='ls -GFh'
alias edit-bash='code ~/.bash_profile'
alias update-bash='. ~/.bash_profile'
alias chromes='open /Applications/Google\ Chrome.app --args --remote-debugging-port=9222 --disable-web-security --user-data-dir'
alias dc="docker-compose"
alias d="docker"
alias k=kubectl
alias vpn="osascript ~/vpn/vpn.applescript"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

function gitr(){
	echo "Running git reset --hard ${1}/${2}"
	git reset --hard ${1}/${2}
}

function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl get --ignore-not-found ${i}
  done
}


# Bash wrappers for docker run commands

#
# Helper Functions
#
dcleanup(){
	docker system prune -a
}
del_stopped(){
	local name=$1
	local state
	state=$(docker inspect --format "{{.State.Running}}" "$name" 2>/dev/null)

	if [[ "$state" == "false" ]]; then
		docker rm "$name"
	fi
}

rmctr(){
	# shellcheck disable=SC2068
	docker rm -f $@ 2>/dev/null || true
}
relies_on(){
	for container in "$@"; do
		local state
		state=$(docker inspect --format "{{.State.Running}}" "$container" 2>/dev/null)

		if [[ "$state" == "false" ]] || [[ "$state" == "" ]]; then
			echo "$container is not running, starting it for you."
			$container
		fi
	done
}
az(){
	docker run -it --rm \
		-v "${HOME}/.azure:/root/.azure" \
    	-v "${HOME}/.kube:/root/.kube" \
		--log-driver none \
		${DOCKER_REPO_PREFIX}/microsoft/azure-cli az "$@"
}
hollywood(){
	docker run --rm -it \
		--name hollywood \
    	--cpus=0.3 \
		${DOCKER_REPO_PREFIX}/bcbcarl/hollywood
}
htop(){
	docker run --rm -it \
		--pid host \
		--net none \
		--name htop \
		${DOCKER_REPO_PREFIX}/jess/htop
}
traceroute(){
	docker run --rm -it \
		--net host \
		${DOCKER_REPO_PREFIX}/jess/traceroute "$@"
}
travis(){
	docker run -it --rm \
		-v "${HOME}/.travis:/root/.travis" \
		-v "$(pwd):/usr/src/repo:ro" \
		--workdir /usr/src/repo \
		--log-driver none \
		${DOCKER_REPO_PREFIX}/jess/travis "$@"
}
watchman(){
	del_stopped watchman

	docker run -d \
		-v "${HOME}/Downloads:/root/Downloads" \
		--name watchman \
		${DOCKER_REPO_PREFIX}/jess/watchman --foreground
}
wrk(){
	docker run -it --rm \
		--log-driver none \
		--name wrk \
		${DOCKER_REPO_PREFIX}/jess/wrk "$@"
}
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


dotenv(){
	export $(cat $PWD/.env)
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"

fkill(){
	PID=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	if test -n "$PID" ; then
		echo $PID | xargs kill -9
	fi
}

bash5(){
	docker run -it --rm \
		${DOCKER_REPO_PREFIX}/library/ubuntu bash "$@"
}

ubuntu(){
	docker run -it --rm \
		${DOCKER_REPO_PREFIX}/library/ubuntu "$@"
}

ide(){
    tmux split-window -v -p 30
    tmux split-window -h -p 66
    tmux split-window -h -p 50
}

