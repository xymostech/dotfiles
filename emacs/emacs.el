; ------- Default Emacs Config --------
; Don't show a startup screen
(setq inhibit-startup-screen +1)

; Fish breaks some plugins
(setq shell-file-name "/usr/bin/bash")

; Disable the top menu bar
(menu-bar-mode -1)

; Set some default tab settings
(setq-default c-basic-offset 4      ; indent amount
              tab-width 4           ; size of tabs
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

; Save the place I last visited files
;(require 'saveplace)
;(setq-default save-place t)
;(setq save-place-file "~/.emacs.d/save-places")

; Turn off the blinking cursor
(setq blink-cursor-mode nil)

; Highlight the line the cursor is on
(global-hl-line-mode t)

; Set the default line wrap
(setq-default fill-column 79)

; Use the x clipboard
;(setq x-select-enable-primary nil)
;(setq x-select-enable-clipboard t)

; Make the mark ring better
(setq set-mark-command-repeat-pop t)
(setq mark-ring-max 100)

; End sentences with a single space
(setq sentence-end-double-space nil)

; Make scrolling never jump, ever
;(setq scroll-margin 3)
;(setq scroll-conservatively 10000)
;(setq scroll-up-aggressively 0.01)
;(setq scroll-down-aggressively 0.01)
;(setq scroll-step 1)
;(setq scroll-preserve-screen-position 1)
;(setq redisplay-dont-pause t)

; Make unique filenames more useful
;(require 'uniquify)
;(setq uniquify-buffer-name-style 'reverse)
;(setq uniquify-after-kill-buffer-p t)
;(setq uniquify-ignore-buffers-re "^\\*")

; Setup ido
(require 'ido)
(ido-mode t)
;(ido-everywhere t)
;(setq ido-enable-flex-matching t)
;(setq ido-use-filename-at-point nil)
;(setq ido-create-new-buffer 'always)

; Always indent after return. I would try using C-j, but it conflicts with tmux
;(define-key global-map (kbd "RET") 'newline-and-indent)

; Turn on column numbering
(setq column-number-mode t)

; ------- Package setup --------
; Setup the list of package sources
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

; The list of packages I install through package.el
(defvar managed-packages
  '(magit haskell-mode
          ;js2-mode
          less-css-mode
          color-theme
          ;rust-mode
          smart-mode-line
          ;lua-mode
          markdown-mode
          ;glsl-mode
          ))

; The list of packages I manually manage
(defvar manual-packages
  '(web-mode editor-config molokai-theme color-theme-molokai))

; Setup package.el
(require 'package)
(package-initialize)

; Ensure all of the packages are loaded
;(package-refresh-contents)
;(dolist (package managed-packages)
  ;(when (not (package-installed-p package))
    ;(package-install package)))

; Add manual plugin paths (this automatically adds everything in ~/.emacs.d/manual/)
(setq load-path
      (append
       (delq nil
             (mapcar (lambda (file)
                       (and (file-directory-p (concat "~/.emacs.d/manual/" file))
                            (not (equal file "."))
                            (not (equal file ".."))
                            (expand-file-name (concat "~/.emacs.d/manual/" file))))
                     (directory-files (expand-file-name "~/.emacs.d/manual/"))))
       load-path))

; ------- Filetype Specific Settings -------

(mapcar
 (lambda (data)
          (autoload (car data) (cdr data) nil t))
 '(
   (markdown-mode . "markdown-mode")
   (js2-mode . "js2-mode")
   (web-mode . "web-mode")
  ))

; (setq auto-mode-alist
;       (append auto-mode-alist
;               '(
;                 ("\\.jsx\\'" . web-mode)
;                )))

; change some indenting settings in C++
;(add-hook 'c++mode-hook
;          (lambda ()
;            (setq c-basic-offset 8)
;            (setq tab-width 8)
;            (setq indent-tabs-mode t)))

; Add mail-mode for mutt
;(add-to-list 'auto-mode-alist '("/tmp/mutt.*" . mail-mode))

;(autoload 'elm-mode "elm-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.elm\\'" . elm-mode))

;(setenv "PATH" (concat (getenv "PATH") ":~/.elm/bin"))
;(add-to-list 'exec-path "~/.elm/bin")

;(autoload 'markdown-mode "markdown-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'haskell-mode-hook 'haskell-indent-mode)

;(require 'lua-mode)
;(setq lua-indent-level 2)

;(autoload 'glsl-mode "glsl-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))

; ------- Plugin Specifc Settings --------

; Setup linum (cause nlinum causes segfaults!?)
(require 'linum)
; Use our own formatting function to get the number with a single
; space after it.
(defun linum-format-func (line)
  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
    (propertize (format (format "%%%dd " w) line) 'face 'linum)))
(setq linum-format 'linum-format-func)
(global-linum-mode 1)

;(autoload 'rust-mode "rust-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;(autoload 'web-mode "web-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

;(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
;(defadvice web-mode-highlight-part (around tweak-jsx activate)
;    (if (equal web-mode-content-type "jsx")
;              (let ((web-mode-enable-part-face nil))
;                        ad-do-it)
;          ad-do-it))

;(add-hook 'web-mode-hook
;          (lambda ()
;            (setq web-mode-css-indent-offset 4)
;            (setq web-mode-code-indent-offset 4)
;            (setq web-mode-style-padding 2)
;            (setq web-mode-script-padding 2)))

; Setup smart-mode-line
(require 'smart-mode-line)
(setq
 sml/replacer-regexp-list
 '(
   ("^~/repos/dotfiles/" ":dotfiles:")
   ("^~/khan/webapp/" ":webapp:")
   ("^~/Dropbox/Projects/" ":projects:")
   )
 )
(setq sml/theme 'dark)
;(add-to-list 'sml/replacer-regexp-list '("^~/repos/dotfiles/" ":.files:") t)
(setq sml/no-confirm-load-theme t)
(sml/setup)

; Enable auctex
;(load "auctex.el" nil t t)

; Don't break on inline math
;(add-hook 'LaTeX-mode-hook
;          (lambda ()
;            (add-to-list 'fill-nobreak-predicate 'texmathp)))

; Enable some whespace settings
(setq whitespace-style '(face trailing spaces-mark tab-mark))
(global-whitespace-mode 1)

; Setup less
;(autoload 'less-css-mode "less-css-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

; Setup editor config
;(load "editorconfig")

; Set up magit
;(require 'magit)

; -------- Random Extra Functions -------

; Paste from the x clipboard
(defun x-paste ()
  (interactive)
  (call-process "xclip" nil t nil "-o" "-selection" "clipboard"))

; Copy to the x clipboard
(defun x-copy ()
  (interactive)
  (call-process-region (region-beginning) (region-end)
                       "xclip" nil 0 nil "-i" "-selection" "clipboard")
  (deactivate-mark))

; Fix the javascript regexp regexp for js-mode
;(add-hook 'js-mode-hook
;  (lambda ()
;    (defun js-syntax-propertize-regexp (end)
;      (when (eq (nth 3 (syntax-ppss)) ?/)
;        ;; A /.../ regexp.
;        (when (re-search-forward "\\(\\/\\|\\\[[^]]*?\\\]\\|[^/[]\\)*?\\(\\/\\|\\\[[^]]*\\]\\|[^\\/]\\)/" end 'move)
;          (put-text-property (1- (point)) (point)
;                             'syntax-table (string-to-syntax "\"/")))))))

; Calculate the closest defined (i.e. builtin) color to a given
; color. This is done automatically by emacs when given a color that
; isn't supported, so isn't necessary, but is interesting to see
; cl-lib in action.

;(require 'cl-lib)
;(defun closest-defined-color (color)
;  (cl-reduce
;   (lambda (prev-best test)
;     (if (< (color-distance color test) (color-distance color prev-best))
;         test
;       prev-best))
;   (defined-colors)
;   :initial-value "black"))

(custom-set-faces
 '(default ((t (:background "color-232" :foreground "color-253"))))
 '(font-lock-builtin-face ((t (:foreground "brightyellow"))))
 '(font-lock-comment-face ((t (:foreground "color-241"))))
 '(font-lock-constant-face ((t (:foreground "brightmagenta"))))
 '(font-lock-negation-char-face ((t (:foreground "brightmagenta"))))
 '(font-lock-function-name-face ((t (:foreground "brightgreen"))))
 '(font-lock-keyword-face ((t (:foreground "brightred"))))
 '(font-lock-string-face ((t (:foreground "cyan"))))
 '(font-lock-type-face ((t (:foreground "brightcyan"))))
 '(font-lock-variable-name-face ((t (:foreground "brightgreen"))))
 '(region ((t (:background "#5F005F"))))
 '(hl-line ((t (:background "color-235"))))
 )
