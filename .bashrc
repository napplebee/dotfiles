# .bashrc

# Setup the proxy
# export http_proxy=http://webproxy:3128/
# export https_proxy=$http_proxy
# export ftp_proxy=$http_proxy
# export rsync_proxy=$http_proxy
# export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls'
alias v='vim'
alias ..="cd .."
alias ...="cd ../../"
alias clr="clear"
alias tailf="tail -f"
alias gst="git status"
alias gce="git checkout"
alias gup="git pull && git merge origin master"
alias pull="git pull"
alias push="git push"
alias gco="git commit"
alias add="git add"
alias gg="git grep -n --heading -C 3"
alias glogf="git diff-tree --no-commit-id --name-only -r"
alias pipf="pip freeze"
alias pipi="pip install"
alias ff="find . -type f -name"
alias main="cd /usr/local/git_tree/main"
realpath() { pushd . > /dev/null; if [ -d "$1" ]; then cd "$1"; dirs -l +0; else cd "`dirname \"$1\"`"; cur_dir=`dirs -l +0`; if [ "$cur_dir" == "/" ]; then echo "$cur_dir`basename \"$1\"`"; else echo "$cur_dir/`basename \"$1\"`"; fi; fi; popd > /dev/null; }


if [ -d "/usr/local/git_tree/main/" ]
then
    alias main="cd /usr/local/git_tree/main/"
	alias authors="/usr/local/git_tree/main/bin/authors.pl"
    alias tmpl="cd /usr/local/git_tree/affiliate_data"
else
    alias main="cd ~/projects/main/"
	alias authors="~/projects/main/bin/authors.pl"
    alias tmpl="cd ~/projects/affiliate_data"
fi

if [ -d "/usr/local/git_tree/main/" ]
then
    alias main="cd /usr/local/git_tree/main/"
else
    alias main="cd ~/projects/main/"
fi

pscp () {
    user=`whoami`
    full_path=`realpath $1`
    echo "scp $user@$HOSTNAME:$full_path ."
}

init_git_branch() {
    local branch
    branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    # echo $branch
    if [ "$branch" != "" ]
    then
        git_branch="[$branch]"
    else
        git_branch=""
    fi
}

tmpl_sync () {
	rsync -vrzlu --exclude='.*' /Users/sbelikov/projects/affiliate_data/ sbelikov-$1.dev.booking.com:/usr/local/git_tree/affiliate_data/
}

b_sync () {
	rsync -vrzlu --exclude='.*' /Users/sbelikov/projects/main/ sbelikov-$1.dev.booking.com:/usr/local/git_tree/main/
}

# define colors
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"

export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad
export LSCOLORS=Gxfxcxdxbxegedabagacad
# http://geoff.greer.fm/lscolors/
export EDITOR=nano

export PROMPT_COMMAND="init_git_branch; $PROMPT_COMMAND"
export PS1="$C_LIGHTGRAY\\t.\\[\\e[1;32m\\]$C_DEFAULT\\u@\\h\\[\\e[0m\\]:$C_LIGHTCYAN\\w$C_YELLOW\$git_branch$C_DEFAULT\\$ "

export PATH=$PATH
export PATH=~/bin:/usr/local/bin:$PATH:/sbin:/usr/sbin
export TERM="xterm-256color"
#--------------------------------------------------
# function fix-ssh() {  
# 	good_socket=$(perl -wle 'print +(sort({ (stat($b))[11] <=> (stat($a))[10] } grep -O, glob shift))[0]' '/tmp/ssh*/*agent*');
# 	if test -n "$good_socket"; then
# 		ln -sf $good_socket ~/.ssh_auth_sock;
# 		export SSH_AUTH_SOCK=~/.ssh_auth_sock;
# 	fi
# }
# 							 
# export SSH_AUTH_SOCK=~/.ssh_auth_sock;
# fix-ssh;
#-------------------------------------------------- 

#--------------------------------------------------
# if [ -z "$TMUX" ]; then
# 	if [ ! -z "$SSH_TTY" ]; then
# 		if [ ! -z "SSH_AUTH_SOCK" ]; then
# 			ln -sf "$SSH_AUTH_SOCK" "$HOME/.wrap_auth_sock"
# 		fi
# 		export SSH_AUTH_SOCK="$HOME/.wrap_auth_sock"
# 		exec /usr/bin/tmux "$@"
# 	fi
# else
# 	exec /usr/bin/tmux "$@"
# fi
#-------------------------------------------------- 
