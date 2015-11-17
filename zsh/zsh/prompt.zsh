status() {
    LAST_STATUS=$?
    if test $LAST_STATUS != 0; then
        printf "%%F{red}$LAST_STATUS %%f"
    fi
}

git_prompt() {
    if git show-ref -q HEAD 2>/dev/null; then
        printf "%%F{blue}("
        if git symbolic-ref HEAD >/dev/null 2>/dev/null; then
            printf "$(git symbolic-ref --short HEAD)"
        else
            printf "("
            git rev-parse HEAD | head -c 8
            printf ")"
        fi
        printf ") %%f"
    fi
}

short_pwd() {
    pwd | perl -pe 's|^\Q$ENV{HOME}\E|~|' | perl -pe 's#([^/])[^/]+/#\1/#gi'
}

setopt prompt_subst
PROMPT='$(status)$(git_prompt)%F{green}$(short_pwd)%f %% '
