# Setup my path
set -x PATH /usr/local/bin /usr/local/sbin /usr/bin
set -x PATH $PATH /usr/bin/vendor_perl

set -x TERM xterm-256color

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
