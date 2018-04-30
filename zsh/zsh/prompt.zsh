status() {
    LAST_STATUS=$?
    if test $LAST_STATUS != 0; then
        printf "%%F{red}$LAST_STATUS %%f"
    fi
}

git_prompt() {
    if git show-ref -q HEAD 2>/dev/null; then
        printf "%%F{yellow}("
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

function preexec() {
    timer=$(date +%s%3N)
}

function precmd() {
    if [ $timer ]; then
        timer_now=$(date +%s%3N)
        timer_diff=$(($timer_now - $timer))

        if test $timer_diff -lt 1000; then
            command_time="${timer_diff}ms"
        elif test $timer_diff -lt 60000; then
            command_time="$((timer_diff / 1000))s"
        elif test $timer_diff -lt 3600000; then
            command_time="$((timer_diff / 60000))m $(((timer_diff % 60000) / 1000))s"
        else
            command_time="$((timer_diff / 3600000))h $(((timer_diff % 3600000) / 60000))m"
        fi
        unset timer
    else
        command_time=
    fi
}

function command_time() {
    if test -n "$command_time"; then
        printf "%%F{cyan}($command_time) %%f"
    fi
}

setopt prompt_subst
PROMPT='$(status)$(command_time)$(git_prompt)%F{green}$(short_pwd)%f %% '
