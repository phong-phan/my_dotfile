# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Aliases:
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
alias desk='cd /home/phong/Desktop/ ; l'
alias diff='colordiff'
alias dk='docker'
alias dl='cd /home/phong/Downloads/; l '
alias docu='cd /home/phong/Documents/ ; l'
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

# Checking domain all records:
function  s(){
	dog $1 ANY
}
# Quickly create a tmux session and screen base on current location:
function tn(){
	# if [ -z "$TMUX" ]; then
	# 	echo "Not currently in Tmux"
	# fi
	# Session name just need not be empty:
	SESSION_NAME=$(tmux list-sessions |awk -F ':' '{print $1}')
	# If empty, create it:
	if [ -z "$SESSION_NAME" ]; then
		tmux new -s $(pwd | sed "s/.*\///g")
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
# IP Spam Check:
function spamchk(){
	amispammer -i $1
}
#mkdir and cd at the same time
function mkcd () {
	mkdir "$1"
	cd "$1"
}
#Backup file:
function bk(){
	cp -pv $1 $1_$(date +%Y%m%d%H)
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
