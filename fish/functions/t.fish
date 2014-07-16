function t
    if tmux -q has-session -t $argv 2>/dev/null
        command tmux -2 attach-session -d -t $argv
    else
        command tmuxifier s $argv
    end
end