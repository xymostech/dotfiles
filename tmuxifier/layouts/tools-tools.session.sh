session_root "~/khan/devtools/content-tools-tools/"

/home/xymostech/bin/ed khan ~/khan/
export EMACS_SERVER_NAME=khan

if initialize_session "tools-tools"; then
  new_window "emacs"
  new_window "shell"
  select_window 1
fi

finalize_and_go_to_session
