; ------- Default Emacs Config --------
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

; Add extra plugin paths
(setq load-path
      (append (mapcar 'expand-file-name
                      '(
                        "~/.emacs.d/evil/"
                        "~/.emacs.d/nlinum/"
                        "~/.emacs.d/color-theme/"
                        "~/.emacs.d/color-theme-molokai/"
                        ))
              load-path))

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

; ------- Filetype Specific Settings -------

;(require 'cmake-mode)
;(setq auto-mode-alist
;      (append auto-mode-alist
;              '(
;                ("\\.jsx\\'" . javascript-mode)
;                ("CMakeLists\\.txt\\'" . cmake-mode)
;                ("\\.cmake\\'" . cmake-mode)
;               )))

; change some indenting settings in C++
(add-hook 'c++mode-hook
          (lambda ()
            (setq c-basic-offset 8)
            (setq tab-width 8)
            (setq indent-tabs-mode t)))

; ------- Plugin Specifc Settings --------

; Enable evil-mode globally
(require 'evil)
(evil-mode 1)

; Setup nlinum
(require 'nlinum)
(setq nlinum-format "%d ")
(global-nlinum-mode 1)

; Enable my colorscheme
(require 'color-theme-molokai)
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-molokai)))

; Setup smart-mode-line
;(sml/setup)

; Enable auctex
;(load "auctex.el" nil t t)

; Don't break on inline math
;(add-hook 'LaTeX-mode-hook
;          (lambda ()
;            (add-to-list 'fill-nobreak-predicate 'texmathp)))

; Enable some whespace settings
;(global-whitespace-mode 1)
;(setq whitespace-style '(face trailing spaces-mark tab-mark))

; -------- Random Extra Functions -------

;(add-hook 'js-mode-hook
;  (lambda ()
;    (defun js-syntax-propertize-regexp (end)
;      (when (eq (nth 3 (syntax-ppss)) ?/)
;        ;; A /.../ regexp.
;        (when (re-search-forward "\\(\\/\\|\\\[[^]]*?\\\]\\|[^/[]\\)*?\\(\\/\\|\\\[[^]]*\\]\\|[^\\/]\\)/" end 'move)
;          (put-text-property (1- (point)) (point)
;                             'syntax-table (string-to-syntax "\"/")))))))
