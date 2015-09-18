# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/khan/hs-webapp"

/home/xymostech/bin/ed hs-webapp ~/khan/hs-webapp
export EMACS_SERVER_NAME=hs-webapp

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "hs-webapp"; then
  new_window "emacs"
  new_window "shell"
  new_window "ghci"
  new_window "serve"

  select_window 2
  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
