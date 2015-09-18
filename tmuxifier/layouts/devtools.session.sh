session_root "~/khan/devtools/"

/home/xymostech/bin/ed khan ~/khan/
export EMACS_SERVER_NAME=khan

if initialize_session "devtools"; then
  new_window "emacs"
  new_window "shell"
  select_window 1
fi

finalize_and_go_to_session
