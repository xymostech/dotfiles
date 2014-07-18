# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/general"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "general"; then

  new_window "shell"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
