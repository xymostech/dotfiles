# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/music"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "ncmpcpp"; then
  new_window "ncmpcpp"
  run_cmd "ncmpcpp"

  new_window "shell"

  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
