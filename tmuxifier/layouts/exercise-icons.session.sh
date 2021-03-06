# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/khan/exercise-icons"

/home/xymostech/bin/ed khan ~/khan/
export EMACS_SERVER_NAME=khan

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "exercise-icons"; then

  load_window "emacs"

  new_window "shell"

  new_window "remote"

  select_window 2
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
