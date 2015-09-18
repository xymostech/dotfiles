# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/.emacs.d/"

/home/xymostech/bin/ed emacs ~/.emacs.d/
export EMACS_SERVER_NAME=emacs

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "emacs"; then
  new_window "emacs"
  run_cmd "~/bin/e ~/.emacs.el"
  new_window "shell"

  select_window 2
  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
