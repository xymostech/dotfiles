# Setup my path
set -x PATH /usr/local/bin /usr/local/sbin /usr/bin
set -x PATH ~/bin $PATH
set -x PATH $PATH ~/khan/devtools/arcanist/khan-bin ~/khan/devtools/git-bigfile/bin #~/khan/devtools/elastic-mapreduce-ruby ~/khan/devtools/google_appengine_linux
set -x PATH $PATH /usr/bin/vendor_perl
set -x PATH $PATH ~/.tmuxifier/bin
set -x PATH $PATH ~/.gem/ruby/2.1.0/bin
set -x PATH $PATH ~/.npm/bin
set -x PATH $PATH ~/.elm/bin
set -x PATH $PATH ~/repos/urbit/bin

set -x _OLD_VIRTUAL_PATH $PATH

#set -x PYTHONPATH $PYTHONPATH ~/khan/devtools/google_appengine_linux

# Workaround for forcing xterm-256color
if test $TERM = "xterm"
    set -x TERM "xterm-256color"
end

# Virtualenv management
set -x VIRTUAL_ENV_DISABLE_PROMPT "yes"

# Set my editor
set -x EDITOR ~/bin/e

# get rid of fish's greeting
set fish_greeting

# Add tmuxifier completions
source ~/.tmuxifier/completion/tmuxifier.fish

# an improved ls
function ls
    command ls -AFs1kG --color=auto $argv
end

# Make time format in the standard way
function time
    command time -p $argv
end

# copy to the ctrl-v clipboard
function clip
    command xclip -selection clipboard $argv
end

# always run tmux with -2
function tmux
    command tmux -2 $argv
end

# Custom completions
complete -f -c t -a '(tmuxifier list-sessions)' -d 'Create a tmux session'
complete -f -c t -a '(tmux list-sessions 2> /dev/null | sed "s/: .*//")' -d 'Load the tmux session'

complete -f -c net -a 'up start' -d 'Start the network'
complete -f -c net -a 'down stop' -d 'Stop the network'
complete -f -c net -a 'restart' -d 'Restart the network service'
complete -f -c net -a 'reset' -d 'Reload all netctl profiles'

complete -f -c activate -a '(command ls ~/.virtualenv)' -d 'Switch to a virtualenv'
