function t
    if tmux -q has-session -t $argv 2>/dev/null
        command tmux -2 attach-session -d -t $argv
    else if tmuxifier ls | grep -q $argv
        command tmuxifier s $argv
    else
        command tmux -2 new-session -s $argv
    end
end