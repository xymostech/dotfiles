# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/khan/webapp"

/home/xymostech/bin/ed khan ~/khan/
export EMACS_SERVER_NAME=khan

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "khan"; then
  new_window "emacs"
  new_window "shell"
  new_window "devshell"
  new_window "serve"
  new_window "kake logs"
  run_cmd "tail -f genfiles/kake-server.log"

  select_window 2
  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
