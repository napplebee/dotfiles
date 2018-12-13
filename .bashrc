# .bashrc

# Setup the proxy
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls'
alias v='vim'
alias ..="cd .."
alias ...="cd ../../"
alias clr="clear"
alias tailf="tail -f"
alias ff="find . -type f -name"

alias gst="git status"
alias gce="git checkout"
alias pull="git pull"
alias push="git push"

alias gco="git commit"
alias add="git add"
alias gg="git grep -n --heading -C 3"
alias glogf="git diff-tree --no-commit-id --name-only -r"

alias pipf="pip freeze"
alias pipi="pip install"

alias pupstop='sudo /etc/init.d/puppet stop'  
alias pupstart='sudo /etc/init.d/puppet start'  
alias puptest='sudo /usr/bin/puppet agent --test'  
alias pupdis='sudo puppet agent --disable'  
alias pupchange='sudo /usr/bin/puppet agent --test --debug --environment $USER --noop'  
alias pupchangereal='sudo /usr/bin/puppet agent --test --debug --environment $USER' 

alias hcat="hdfs dfs -cat"
alias hls="hdfs dfs -ls"
alias hmd="hdfs dfs -mkdir"
alias hdu="hdfs dfs -du -h"
alias hcp="hdfs dfs -cp"

# == K8S related stuff
export TILLER_NAMESPACE=kafka
alias kctl="kubectl"
alias kctl-config="kubectl config view"
kssh() {
    kubectl exec -it $1 -- /bin/bash
}

realpath() { pushd . > /dev/null; if [ -d "$1" ]; then cd "$1"; dirs -l +0; else cd "`dirname \"$1\"`"; cur_dir=`dirs -l +0`; if [ "$cur_dir" == "/" ]; then echo "$cur_dir`basename \"$1\"`"; else echo "$cur_dir/`basename \"$1\"`"; fi; fi; popd > /dev/null; }
gup() { 
    git pull origin "$1"
}

if [ -d "/usr/local/git_tree/main/" ]
then
    alias main="cd /usr/local/git_tree/main/"
    alias authors="/usr/local/git_tree/main/bin/authors.pl"
else
    alias main="cd ~/projects/main/"
    alias authors="~/projects/main/bin/authors.pl"
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
        git_branch="($branch)"
    else
        git_branch=""
    fi
}

# define colors
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
export LSCOLORS=Gxfxcxdxbxegedabagacad

C_DEFAULT="\[\033[m\]"
C_GREEN="\[\033[1;32m\]"
C_YELLOW="\[\033[33m\]"

# http://geoff.greer.fm/lscolors/
export EDITOR=vim

source <(helm completion bash)

export PROMPT_COMMAND="init_git_branch; $PROMPT_COMMAND"

#export PS1="$C_GREEN[$C_DEFAULT\\t:\\[\\e[1;32m\\]$C_GREEN\\h\\[\\e[0m\\]:$C_LIGHTCYAN\\w$C_YELLOW\$git_branch$C_GREEN]$C_DEFAULT\n=> "
export PS1="$C_GREEN[$C_DEFAULT\[\033[37m\]\t:\[\033[1;32m\]\h\[\033[1;36m\]:\w$C_YELLOW\$git_branch$C_GREEN]$C_DEFAULT\n=> "

export PATH=$PATH
export PATH=~/bin:/usr/local/bin:/sbin:/usr/sbin:$PATH

umask 002
if [ -d "/Users/sbelikov/projects/" ]
then
    cd /Users/sbelikov/projects/
fi

_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh
