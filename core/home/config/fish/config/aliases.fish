#!/usr/bin/env fish

alias sudo='sudo '
alias x="exit"
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias l='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                        # Confirm before overwriting something
alias df='df -h'                        # Human-readable sizes
alias free='free -m'                    # Show sizes in MB
alias ag='ag --path-to-ignore ~/.ignore'

alias close="tmux kill-window -t"
alias rm='rm -irv'
alias gitignored="git ls-files --others -i --exclude-standard"
alias kill_tmux_session="tmux kill-session"
alias disk='baobab'
alias mount-usb='udiskie-mount /dev/sdb1'
alias umount-usb='udiskie-umount /dev/sdb1'
alias c="git rebase --continue"
alias s="git rebase --skip"
alias m="git mergetool"
alias lg="gitui"
alias gui="gitui"

alias w="cd $HOME/Workdir/src/github.com/dafiti-group"
# alias w="cd $HOME/Workdir/src/github.com/yurifrl"
# alias vim="echo 'no'"

alias g="git"
alias gti="git"

alias lock="i3lock -c 000000 -n"

# alias sudo='sudo '
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias check_for_errors="journalctl -p 3 -xb"
alias mk=microk8s.kubectl
alias k=/run/current-system/sw/bin/kubectl
#alias k=$HOME/.bin/kubectl-in-docker
#alias kubectl=$HOME/.bin/kubectl-in-docker
# alias helm=helm-2
alias tiller=tiller-2
alias vim-edit-alias="vim ~/NixFiles/core/home/config/fish/config/aliases"
alias proj="touch .projectile"
