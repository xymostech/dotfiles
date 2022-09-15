; ------- Default Emacs Config --------
; Don't show a startup screen
(setq inhibit-startup-screen +1)

; Use zsh
(setq shell-file-name "/opt/homebrew/bin/zsh")

; Never make annoying sounds
(setq ring-bell-function 'ignore)

; Disable some UI features
(menu-bar-mode -1)
(scroll-bar-mode -1)
; This needs to run after a few seconds to get the window to register with
; contexts
(run-at-time 6 nil (lambda () (tool-bar-mode -1)))

; Set some default tab settings
(setq-default c-basic-offset 2      ; indent amount
              tab-width 2           ; size of tabs
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

; Turn off the blinking cursor
(setq blink-cursor-mode nil)

; Highlight the line the cursor is on
(global-hl-line-mode t)

; Set the default line wrap
(setq-default fill-column 79)

; Make the mark ring better
(setq set-mark-command-repeat-pop t)
(setq mark-ring-max 100)

; End sentences with a single space
(setq sentence-end-double-space nil)

; Turn on column numbering
(setq column-number-mode t)

; Always vertical split
(setq split-height-threshold 99999)

; Allow emojis to be displayed
(set-fontset-font t 'unicode "Noto Emoji" nil 'prepend)

; Remove electric indent by default
(electric-indent-mode -1)

; Don't use lockfiles, since we're the only one editing these files
(setq create-lockfiles nil)

; Show line numbers everywhere
(global-display-line-numbers-mode)

; Don't ask about saving buffers before grepping
(setq grep-save-buffers nil)

; ------- Package.el setup --------

; Setup the list of package sources
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

; Setup package.el
(require 'package)
(package-initialize)

; Setup use-package
(package-install 'use-package)
(eval-when-compile
  (require 'use-package))

; ------- Filetype Specific Settings -------

; Disable C-z (minimize) in graphical mode
; Note: this must come after package-initialize
(if (display-graphic-p)
    (progn
      (require 'bind-key)
      (unbind-key (kbd "C-z"))))

(use-package saveplace
  :config
  (save-place-mode 1)
  (setq save-place-file "~/.emacs.d/save-places"))

(use-package babylon-mode
  :load-path "~/repos/babylon-mode/"
  :mode "\\.js\\'"
  :mode "\\.jsx\\'"
  :init
  (setq js-indent-level 2)
  (add-to-list 'exec-path "/Users/emilyeisenberg/.nvm/versions/node/v12.22.7/bin"))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(defun helm-maybe-projectile-find-files (arg)
  (interactive "P")
  (if (projectile-project-p)
      (helm-projectile-find-file arg)
    (helm-find-files arg)))

(use-package helm
  :ensure t
  :demand
  :preface (require 'helm-config)
  :bind (("C-x C-f" . helm-maybe-projectile-find-files)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action))
  :config
  (helm-mode 1))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :init
  (setq projectile-enable-caching t)
  :config
  (helm-projectile-on)

  (defun projectile-files-via-ext-command (root command)
    "Get a list of relative file names in the project ROOT by executing COMMAND.
     If `command' is nil or an empty string, return nil.
     This allows commands to be disabled."
    (when (stringp command)
      (let ((default-directory root)
            (buffer (get-buffer-create (generate-new-buffer-name " *git-output*")))
            (result nil))
        (call-process "git" nil buffer nil "ls-files" "-zco" "--exclude-standard")
        (setq result (split-string (with-current-buffer buffer (buffer-string)) "\0" t))
        (kill-buffer buffer)
        result)))

  (defun projectile-dir-files-alien (directory)
    "Get the files for DIRECTORY using external tools."
    (let ((vcs (projectile-project-vcs directory)))
      (projectile-files-via-ext-command directory (projectile-get-ext-command vcs))))
  )

(use-package smart-mode-line
  :ensure t
  :init
  (setq mode-line-format
        '("%e"
          mode-line-front-space
          mode-line-mule-info
          mode-line-client
          mode-line-modified
          mode-line-remote
          mode-line-frame-identification
          mode-line-buffer-identification
          "   "
          mode-line-modes
          mode-line-misc-info
          mode-line-end-spaces))
  :config
  (setq
   sml/replacer-regexp-list
   '(
     ("^~/repos/dotfiles/" ":dotfiles:/")
     ("^~/source/dream/www/" ":dream:/")
     ("^~/source/admin/www/" ":admin:/")
     ("^~/source/pro/www/" ":pro:/")
     ("^~/source/vault/www/" ":vault:/")
     ("^~/source/lib/www/" ":lib:/")
     ("^~/source/" ":source:/")
     )
   )
  (setq sml/theme 'dark)
  (setq sml/no-confirm-load-theme t)
  (setq sml/name-width 999)
  (setq sml/mode-width 'full)
  (sml/setup))

(use-package whitespace-mode
  :no-require t
  :config
  (setq whitespace-style '(face trailing spaces-mark tab-mark))
  (global-whitespace-mode 1))

(use-package magit
  :ensure t)

(use-package multiple-cursors
  :bind (("M-SPC" . set-rectangular-region-anchor)))

; -------- My custom color scheme ---------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#080808" :foreground "#dadada"))))
 '(font-lock-builtin-face ((t (:foreground "yellow"))))
 '(font-lock-comment-face ((t (:foreground "#888"))))
 '(font-lock-constant-face ((t (:foreground "light slate blue"))))
 '(font-lock-function-name-face ((t (:foreground "chartreuse"))))
 '(font-lock-keyword-face ((t (:foreground "orange red"))))
 '(font-lock-negation-char-face ((t (:foreground "salmon"))))
 '(font-lock-string-face ((t (:foreground "deep sky blue"))))
 '(font-lock-type-face ((t (:foreground "deep pink"))))
 '(font-lock-variable-name-face ((t (:foreground "lawn green"))))
 '(hl-line ((t (:background "#444"))))
 '(region ((t (:background "midnight blue")))))

; -------- Random Extra Functions -------

(setq search-dir "~")

(defun sgrep (regexp)
  (interactive
   (list (grep-read-regexp)))
  (let ((default-directory search-dir)
        (compilation-environment (cons "PAGER=" compilation-environment))
        (command (grep-expand-template "/opt/homebrew/bin/rg --vimgrep <R>" regexp)))
    (compilation-start command 'grep-mode)))
(global-set-key (kbd "s-f") 'sgrep)

(defun save-open-buffers ()
  (interactive)
  (write-region
   (pp (seq-filter (lambda (x) (if x t nil)) (mapcar 'buffer-file-name (buffer-list))))
   nil
   "~/buffers.txt"))

(defun load-open-buffers ()
  (interactive)
  (let ((buffers
         (with-temp-buffer
           (insert-file-contents "~/buffers.txt")
           (read (current-buffer)))))
    (mapc 'find-file-noselect buffers)))

(defun ask-before-closing ()
  "Close only if y was pressed."
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to close this frame? "))
      (save-buffers-kill-emacs)
    (message "Canceled frame close")))

(global-set-key (kbd "C-x C-c") 'ask-before-closing)

(defun kill-line-no-kill-ring ()
  "Like kill-line but without adding to the kill ring"
  (interactive)
  (delete-region (point) (line-end-position)))
(global-set-key (kbd "C-M-k") 'kill-line-no-kill-ring)

; -------- machine-specific-settings -------

(load "~/.emacs.d/machine.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package smart-mode-line markdown-mode magit helm-projectile haskell-mode flycheck fill-column-indicator f color-theme))))
