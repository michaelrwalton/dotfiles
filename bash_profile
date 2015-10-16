if [ -f ~/.bash_git ]; then
    source ~/.bash_git
fi

__has_parent_dir () {
    # Utility function so we can test for things like .git/.hg without firing up a
    # separate process
    test -d "$1" && return 0;

    current="."
    while [ ! "$current" -ef "$current/.." ]; do
        if [ -d "$current/$1" ]; then
            return 0;
        fi
        current="$current/..";
    done

    return 1;
}

__vcs_name() {
    if [ -d .svn ]; then
        echo "-[svn]";
    elif __has_parent_dir ".git"; then
        echo "-[$(__git_ps1 'git %s')]";
    elif __has_parent_dir ".hg"; then
        echo "-[hg $(hg branch)]"
    fi
}

addhost () { echo "127.0.0.1 $1" | sudo tee -a /etc/hosts; }

black=$(tput -Txterm setaf 0)
red=$(tput -Txterm setaf 1)
green=$(tput -Txterm setaf 2)
yellow=$(tput -Txterm setaf 3)
dk_blue=$(tput -Txterm setaf 4)
pink=$(tput -Txterm setaf 5)
lt_blue=$(tput -Txterm setaf 6)

bold=$(tput -Txterm bold)
reset=$(tput -Txterm sgr0)

alias dir='dir -F --color=always'
alias cp='cp -iv'
alias rm='rm -i'
alias mv='mv -iv'
alias grep='grep --color=auto -in'
alias ..='cd ..'
alias ll="ls -la"
alias cls="clear"
alias cowfortune="fortune | cowsay"
alias sshconf="cat ~/.ssh/config"
alias tarc="tar cvzf"
alias tarx="tar xvzf"
alias vm='ssh vagrant@127.0.0.1 -p 2222'
alias behat="vendor/bin/behat"

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# Nicely formatted terminal prompt
export PS1='\n\[$bold\]\[$black\][\[$dk_blue\]\@\[$black\]]-[\[$green\]\u\[$yellow\]\[$black\]]-[\[$pink\]\w\[$black\]]\[\033[0;33m\]$(__vcs_name) \[\033[00m\]\[$reset\]\n\[$reset\]\$ '

source ~/.bash_profile.local
export PATH=/usr/local/lib:/usr/local/bin:$PATH
