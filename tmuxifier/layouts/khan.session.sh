# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/khan/"

/home/xymostech/bin/ed khan ~/khan/
export EMACS_SERVER_NAME=khan

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "khan"; then
  new_window "emacs"
  new_window "shell"
  new_window "shell2"
  new_window "remote"
  run_cmd "ssh KADev"

  select_window 2
  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
