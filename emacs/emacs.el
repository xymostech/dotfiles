;------- Default Emacs Config --------
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

; Add extra plugin paths (this automatically adds everything in ~/.emacs.d/)
(setq load-path
      (append
       (delq nil
             (mapcar (lambda (file)
                       (and (file-directory-p (concat "~/.emacs.d/" file))
                            (not (equal file "."))
                            (not (equal file ".."))
                            (expand-file-name (concat "~/.emacs.d/" file))))
                     (directory-files (expand-file-name "~/.emacs.d/"))))
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
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

; Setup ido
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)

; Always indent after return. I would try using C-j, but it conflicts with tmux
(define-key global-map (kbd "RET") 'newline-and-indent)

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

; Add mail-mode for mutt
(add-to-list 'auto-mode-alist '("/tmp/mutt.*" . mail-mode))

; ------- Plugin Specifc Settings --------

; Disable some evil features
(setq evil-want-C-i-jump nil)

; Enable evil-mode globally
(require 'evil)
(evil-mode 1)

; Setup nlinum
(require 'nlinum)
(setq nlinum-format "%d ")
(global-nlinum-mode 1)

; Enable my colorscheme
(require 'molokai-theme)

(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-css-indent-offset 4)
            (setq web-mode-code-indent-offset 4)
            (setq web-mode-style-padding 2)
            (setq web-mode-script-padding 2)))

; Setup smart-mode-line
(require 'smart-mode-line)
(add-to-list 'sml/replacer-regexp-list '("^~/repos/dotfiles/" ":.files:") t)
(setq sml/no-confirm-load-theme t)
(sml/setup)

; Enable auctex
;(load "auctex.el" nil t t)

; Don't break on inline math
;(add-hook 'LaTeX-mode-hook
;          (lambda ()
;            (add-to-list 'fill-nobreak-predicate 'texmathp)))

; Enable some whespace settings
(global-whitespace-mode 1)
(setq whitespace-style '(face trailing spaces-mark tab-mark))

; Setup less
(autoload 'less-css-mode "less-css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

; -------- Random Extra Functions -------

(defun x-paste ()
  (interactive)
  (call-process "xclip" nil t nil "-o"))

(defun x-copy ()
  (interactive)
  (call-process-region (region-beginning) (region-end)
                       "xclip" nil 0 nil "-i" "-selection" "clipboard")
  (deactivate-mark))

;(add-hook 'js-mode-hook
;  (lambda ()
;    (defun js-syntax-propertize-regexp (end)
;      (when (eq (nth 3 (syntax-ppss)) ?/)
;        ;; A /.../ regexp.
;        (when (re-search-forward "\\(\\/\\|\\\[[^]]*?\\\]\\|[^/[]\\)*?\\(\\/\\|\\\[[^]]*\\]\\|[^\\/]\\)/" end 'move)
;          (put-text-property (1- (point)) (point)
;                             'syntax-table (string-to-syntax "\"/")))))))
