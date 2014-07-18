# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Dropbox/Projects/jsGameLib"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "jsgamelib"; then
  /home/xymostech/bin/ed jsgamelib
  export EMACS_SERVER_NAME=jsgamelib

  load_window "emacs"

  new_window "shell"

  new_window "serve"
  run_cmd "make serve"

  new_window "doc-serve"
  run_cmd "make doc-serve"

  select_window 2
  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
