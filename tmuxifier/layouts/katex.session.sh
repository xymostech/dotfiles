# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/khan/KaTeX"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "katex"; then
  /home/xymostech/bin/ed khan
  export EMACS_SERVER_NAME=khan

  load_window "emacs"

  new_window "shell"

  new_window "serve"
  run_cmd "make serve"

  new_window "selenium"
  run_cmd "java -jar ~/khan/devtools/selenium-server-standalone-2.42.2.jar"

  new_window "huxley"

  select_window 2
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
