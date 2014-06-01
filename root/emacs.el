; Don't show a startup screen
(setq inhibit-startup-screen +1)

; Fish breaks some plugins
(setq shell-file-name "/usr/bin/bash")

; Disable the top menu bar
(menu-bar-mode -1)

; Set some default tab settings
(setq-default c-basic-offset 4 ; indent amount
              tab-width 4 ; size of tabs
              indent-tabs-mode nil) ; don't use tab characters

; Use linux-style bracketing
(setq c-default-style "linux")

; Don't prompt to follow symlinks
(setq vc-follow-symlinks t)

; Some backup file settings
(setq backup-directory-alist `(("." . "~/.tmp")))
(setq backup-by-copying t)

; Some auto-save file settings
(setq auto-save-file-name-transforms
      '((".*" "~/.tmp" t)))

; Set the default line wrap
(setq-default fill-column 80)

; Use the x clipboard
(setq x-select-enable-primary nil)
(setq x-select-enable-clipboard t)

; Make the mark ring better
(setq set-mark-command-repeat-pop t)
(setq mark-ring-max 100)

; End sentences with a single space
(setq sentence-end-double-space nil)

; Make scrolling never jump, ever
(setq scroll-margin 3)
(setq scroll-conservatively 10000)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq scroll-step 1)
(setq scroll-preserve-screen-position 1)
(setq redisplay-dont-pause t)

; Make unique filenames more useful
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

(global-linum-mode 1)
