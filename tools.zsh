### proxy
alias proxy="export http_proxy=127.0.0.1:7890 && export https_proxy=$http_proxy"
### git addon: check dir with uncommitted changes
function show-change {
    # legal check
    if [ -d "$$1" ]; then
        echo "no such dir: $1"
        exit
    fi
    # args count
    if [ "$#" -ge 1 ]; then
        pushd "$1" >/dev/null
    fi
    for d in */; do
        # remove trailing slash
        dir_name="${d%/}"
        # check if is git directory
        if [ -d "$dir_name/.git" ]; then
            cd "$dir_name" || continue
            # check if has uncommitted changes
            has_unstaged=false
            has_staged=false
            if ! git diff --quiet; then
                echo -n "Unstaged changes in: $dir_name"
                has_unstaged=true
            fi
            if ! git diff --cached --quiet; then
                has_staged=true
                if [ "$has_unstaged" = true ]; then
                    echo -n " (Also staged changes)"
                else
                    echo -n "Staged changes in: $dir_name"
                fi
            fi
            # output LF
            if [[ "$has_unstaged" = true || "$has_staged" = true ]]; then
                echo ""
            fi
            cd ..
        else
            echo "Ignoring non-git directory: $dir_name"
        fi
    done
    # args count
    if [ "$#" -ge 1 ]; then
        popd >/dev/null
    fi
}
### check dir with uncommitted changes
function show-stash {
    # legal check
    if [ -d "$$1" ]; then
        echo "no such dir: $1"
        exit
    fi
    # args count
    if [ "$#" -ge 1 ]; then
        pushd "$1" >/dev/null
    fi
    for d in */; do
        dir_name="${d%/}"
        if [ -d "$dir_name/.git" ]; then
            cd "$dir_name" || continue
            STASH_COUNT=$(git stash list | wc -l)
            if [ "$STASH_COUNT" -gt 0 ]; then
                echo "found stash in $dir_name"
            fi
            cd ..
        else
            echo "Ignoring non-git directory: $dir_name"
        fi
    done
    # args count
    if [ "$#" -ge 1 ]; then
        popd >/dev/null
    fi
}
### mail after command
function mailafter {
    if "$@"; then
        echo -e "To: kymdon@qq.com\nFrom: kymdon@qq.com\nSubject: Command Done from remote\n\nSuccess: $
@" | ssmtp kymdon@qq.com
    else
        echo -e "To: kymdon@qq.com\nFrom: kymdon@qq.com\nSubject: Command Done from remote\n\nFailed: $@
" | ssmtp kymdon@qq.com
    fi
}
