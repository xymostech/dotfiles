# Setup my path
set -x PATH /usr/local/bin /usr/local/sbin /usr/bin
set -x PATH $PATH ~/khan/devtools/arcanist/khan-bin ~/khan/devtools/elastic-mapreduce-ruby ~/khan/devtools/google_appengine_linux
set -x PATH $PATH /usr/bin/vendor_perl
set -x PATH $PATH ~/.gem/ruby/2.0.0/bin
set -x PATH $PATH ~/bin
set -x PATH $PATH ~/.tmuxifier/bin
set -x PATH ~/.cabal/bin $PATH

set -x TERM xterm-256color

set -x _OLD_VIRTUAL_PATH $PATH

set -x PYTHONPATH $PYTHONPATH ~/khan/devtools/google_appengine_linux

# Virtualenv management
set -x VIRTUAL_ENV_DISABLE_PROMPT "yes"

# Set my editor
set -x EDITOR /usr/bin/emacs

# get rid of fish's greeting
set fish_greeting

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

_virtualenv_handler

