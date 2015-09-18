(defvar al-mode-hook nil)

(defvar al-mode-map
  (make-sparse-keymap)
  "Keymap for aletheia major mode")

(add-to-list 'auto-mode-alist '("\\.al\\'" . al-mode))

(defconst al--keyword-regexp
  (concat "\\<" (regexp-opt '("true" "false" "if" "else" "mutate" "mutable" "ret" "require" "not" "and" "or") t) "\\>"))

(defconst al-font-lock-keywords-1
  (list
   (cons al--keyword-regexp 'font-lock-keyword-face)
   '("\\<\\([a-zA-Z_]+\\)\\>" . font-lock-variable-name-face)
   '("/\\(\\\\/\\|[^/\n]\\)+/" . font-lock-constant-face)
   )
  "Expressions for aletheia mode")

(defvar al-font-lock-keywords al-font-lock-keywords-1)

(defun al-indent-line ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (bobp) ; If we're at the beginning of the file, start at 0
        (indent-line-to 0)
      (let ((cur-indent) (not-indented t))
        (if (looking-at "^[ \t]*]") ; if we're on a line that starts with ], go
                                    ; down an indent
            (progn
              (save-excursion
                (forward-line -1)
                (setq cur-indent (- (current-indentation) default-tab-width)))
              (if (< cur-indent 0)
                  (setq cur-indent 0)))
          (save-excursion
            (while not-indented
              (forward-line -1) ; Look back through the lines
              (if (looking-at "^.*\\[[^]\n]*$") ; If the most recent line ends
                                                ; with a [, use its indentation
                  (progn
                    (setq cur-indent (+ (current-indentation) default-tab-width))
                    (setq not-indented nil))
                (if (looking-at "^[ \t]*]") ; If the most recent line is a ],
                                            ; use its indentation
                    (progn
                      (setq cur-indent (current-indentation))
                      (setq not-indented nil))
                  (if (bobp) ; If we reach the beginning of the file, stay at 0
                      (setq not-indented nil)))))))
        (if cur-indent
            (indent-line-to cur-indent)
          (indent-line-to 0))))))

(defvar al-mode-syntax-table
  (let ((st (make-syntax-table)))
    ; _ is part of words!
    (modify-syntax-entry ?_ "w" st)
    ; // and /* */ comments
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?\n "> b" st)
    ; ' can also be used for strings
    (modify-syntax-entry ?' "\"" st)
    st))

(defun al-mode ()
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table al-mode-syntax-table)
  (use-local-map al-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(al-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'al-indent-line)
  (setq major-mode 'al-mode)
  (setq mode-name "Aletheia mode")
  (run-hooks 'al-mode-hook))

(provide 'al-mode)
