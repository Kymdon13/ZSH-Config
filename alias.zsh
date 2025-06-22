alias l="ls -Fl"
alias ll="ls -Fla"
alias ds="dirs -v"
alias du="du -sh * | sort -hr"
### tmux
function tm {
    if [[ $# == 0 ]]; then
        tmux
    elif [[ $1 == "l" ]]; then
        tmux ls
    elif [[ $1 == "k" ]]; then
        tmux kill-session -t $2
    elif [[ $1 == "r" ]]; then
        tmux rename-session -t $2 $3
    else
        tmux attach-session -t $1 || tmux new-session -s $1
    fi
}
### git
alias gt="git rev-parse --show-toplevel"
alias gdn="git diff --name-only"
