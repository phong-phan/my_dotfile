set -o vi
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
RED='\e[0;31m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
OFF='\033[0m'
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey "^ " forward-word
WORDCHARS+='_'
 HIST_STAMPS="yyyy-mm-dd"
plugins=(zsh-autosuggestions git debian ubuntu docker docker-compose autojump dnf git-prompt zsh-vi-mode kubectl web-search sudo zsh-syntax-highlighting)
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi
export KUBE_EDITOR='vim'
export ANSIBLE_NOCOWS=1
export TERM="xterm-256color"
alias ...='cd ../../; ls'
alias ....='cd ../../../; ls'
alias ..='cd .. ; ls'
alias btop='bpytop'
alias cat='ccat'
alias cd..='cd ..'
alias cl='clear'
alias compose='docker-compose'
alias con='docker ps -a'
alias conclear='docker container stop $(docker container ls -aq); docker container rm -f $(docker container ls -aq)'
alias conrm='docker rm -f'
alias consh='docker exec -it '
alias desk='cd $HOME/Desktop/ ; l'
alias diff='colordiff'
alias dk='docker'
alias dl='cd $HOME/Downloads/; l '
alias docu='cd $HOME/Documents/ ; l'
alias ex='exit'
alias files='nohup nautilus . > /dev/null 2>&1 &'
alias fw='cd -'
alias gg='google '
alias his='history -i'
alias images='docker images'
alias k='microk8s kubectl'
alias kga='microk8s kubectl get all'
alias kgd='microk8s kubectl get deployment'
alias kgp='microk8s kubectl get pod'
alias kgpa='microk8s kubectl get pods -o wide --all-namespaces'
alias kgn='microk8s kubectl get namespace'
alias kgr='microk8s kubectl get replicaset'
alias kgs='microk8s kubectl get svc'
alias l='exa --long  -a --color auto  --icons  --header --git --group-directories-first'
alias m='microk8s'
alias n='npm'
alias o='exa --tree -h --icons --group-directories-first'
alias p='python3'
alias pe='vim ~/.p10k.zsh'
alias ports='sudo netstat -tulanp'
alias rmic='docker system prune -a' # remove all images not in use by any containers
alias rmscon='docker rm $(docker ps -a -q)' #remove all  stopped containers
alias ta='tmux attach'
alias td='tmux detach'
alias v='vim'
alias vadd='vagrant box add' #add a vagrant box
alias ve='vim ~/.vimrc'
alias vhalt='vagrant halt' #this like shutting a down a vm
alias vmini='vagrant init -m' #init a vagrant project with minimal config file
alias vpro='vagrant provision' #force re-provision of vagrant vm
alias vreload='vagrant reload' #reload is required if you change the config file of vagrant
alias vrm='vagrant box' #remove a vagrant box
alias vsnap='vagrant snapshot' #take snapshot of the vm current status
alias vssh='vagrant ssh' #connect to vagrant vm
alias vstat='vagrant status' #checking status of vm
alias vsuspend='vagrant suspend' #suspend a vm instead of shutting down or destroying it
alias vup='vagrant up' #start vagrant environment
alias vi='vim'
alias ze='vim ~/.zshrc'
function  s(){
	dog $1 ANY
}
function tn(){
	# Session name just need not be empty:
	SESSION_NAME=$(tmux list-sessions 2>/dev/null|awk -F ':' '{print $1}' )
	# If empty, create it:
	if [ -z "$SESSION_NAME" ]; then
		tmux new -s $(pwd | sed "s/.*\///g") 2>/dev/null
	else
		# If not empty, attaching to it:
		# tmux attach -t $SESSION_NAME
		NAME=$(pwd | sed "s/.*\///g")
		CURRENT_WINDOWS=$(tmux list-windows | awk '{print $2}' | sed 's/*\|-//g' | tr '\n' ' ' | sed 's/ $//g')
		if [ $(echo "$CURRENT_WINDOWS"| grep "$NAME" ) ]; then
			# change the active windows of session to the one you want and then attach to it:
			tmux select-window -t $SESSION_NAME:$NAME ; tmux a -t $SESSION_NAME
		else
			# create a window with the name you want in the existing session:
			tmux new-window -d -n $NAME -t $SESSION_NAME:
		fi
	fi
}
function ta() {
    # Check if any tmux sessions exist
	chk_session=$(tmux list-session 2>/dev/null)
	if [ ! -z "$chk_session" ] ; then
        # Attach to the client session if it exists
        printf  "${GREEN}Attaching to existing session${OFF}"
        tmux attach -t $(tmux list-sessions| head -n 1  | awk -F : '{print $1}')
	else
        printf  "${YELLOW}There is no session yet, CREATING new one...${OFF}"
        tn > /dev/null 2&>1
    fi
}
# IP Spam Check:
function spamchk(){
	amispammer -i $1
}
# Fast SSH server:
function f(){
	cd  /home/$USER/Custom/passh
	source .env/bin/activate
	bash sshtoserver.sh $1
}
#mkdir and cd at the same time
function mkcd () {
	mkdir "$1"
	cd "$1"
}
#Backup file:
function bk(){
	cp -prv $1 $1_$(date +%Y%m%d%H)
}
#Cheatsheet curl:
function a() {
	curl cheat.sh/$1
}
# Connect ssh to CentOS5 server:
function sshc() {
  ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 $1@$2
}
# Checking connection to ssl ports after issuing SSL certificates.
function st() {
  echo "\033[33m"  "Checking SSL ports:"
  echo "__________"
  echo " - HTTPs: "  "\033[34m"
  echo "__________"
  yes ""|openssl s_client --servername $1 -connect $1:443  |  openssl x509 -text  | grep  "After\|Subject:"
  echo "\033[33m""__________"
  echo   " - IMAPs: " "\033[34m"
  echo "__________"
  #echo "\033[33m""__________"
  yes ""|openssl s_client --servername $1 -connect $1:993  |  openssl x509 -text  | grep  "After\|Subject:"
  echo "\033[33m""__________"
  echo  " - POP3s: " "\033[34m"
  echo "__________"
  yes ""|openssl s_client --servername $1 -connect $1:995  |  openssl x509 -text  | grep  "After\|Subject:"
  echo "\033[33m""__________"
  echo   " - SMTPs: " "\033[34m"
  echo "__________"
  yes ""|openssl s_client --servername $1 -connect $1:465  |  openssl x509 -text  | grep  "After\|Subject:"
}
# Checking server popular ports:
function cn(){
  bash /home/$USER/Custom/daily/server_port_status.sh $1
}
#default ssh to server, if no second param passed-in, default ssh port 22 will be used, else another port will be used
# re: redhat based
# de: debian based
function re() {
		ssh  root@$1 -p ${2:-22}
}
function de() {
		ssh  u1@$1 -p ${2:-22}
}
# Time conversion:
function poc() {
	date -d $1 +"%s"
}
function htime() {
	date -d @$1
}
function ctime(){
  date +%s -d $1
}
function f() {
	cd /home/$USER/Custom/passh
	bash sshtoserver.sh $1
}
function c() {
	python3 /home/$USER/Desktop/pythonlearning/sachk.py $1
}
function t() {
	python3 /home/$USER/Desktop/pythonlearning/report/tracker.py $1 $2
}
function ml() {
	if [ $# -eq 1 ]; then
		python3 /home/$USER/Desktop/pythonlearning/report/maillog.py $1
	elif [ $# -eq 3 ]; then
		python3 /home/$USER/Desktop/pythonlearning/report/maillog.py $1 $2 $3
	else
		echo "Usage: ml ip id mode  OR ml ip"
	fi
}
complete -o default -F __start_microk8s.kubectl k
export PATH=$HOME/.local/bin:/usr/bin/python3:/usr/local/go/bin:$HOME/.cargo/bin:/home/linuxbrew/.linuxbrew/bin:/opt/nvim-linux64/bin:$HOME/.vim/bundle/vim-superman/bin:$PATH
#tree command  replacement with tre
tre() { command tre "$@" -e vim && source "/tmp/tre_aliases_$USER" 2>/dev/null; }
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# Sesh fuction:
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
# init zoxide for faster directories navigation:
eval "$(zoxide init zsh)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Testing function of tmux multiple panes creation:
tmux_ssh_split() {
    local -a hosts=("$@") # Capture all arguments as an array of hosts
    local num_hosts=${#hosts[@]}

    if (( num_hosts == 0 )); then
        echo "Usage: tmux_ssh_split host1 host2 ..."
        return 1
    fi

    # Calculate the number of rows and columns for splitting
    local rows
    rows=$(awk "BEGIN {print int(sqrt($num_hosts))}")
    local cols
    cols=$(awk "BEGIN {print ($num_hosts + $rows - 1) / $rows}")

    # Split the tmux window
    for i in {1..$((num_hosts - 1))}; do
        if (( i % cols == 0 )); then
            tmux split-window -v
        else
            tmux split-window -h
        fi
        tmux select-layout tiled
    done

    # Send SSH commands to each pane (adjust for pane indexing starting at 1)
    local pane_index=1
    for host in "${hosts[@]}"; do
        tmux select-pane -t "$pane_index"
        tmux send-keys "ssh root@$host" C-m
        ((pane_index++))
    done

    # Return to the first pane (index 1)
    tmux select-pane -t 1
}

