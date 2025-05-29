(defvar *40wt/python-mode-keys-remapped* t)

(defun 40ants-remap-python-mode-keys ()
  ;; В python-mode С-с TAB является префиксом для таких команд:
  ;;
  ;; C-c TAB a       python-add-import
  ;; C-c TAB f       python-fix-imports
  ;; C-c TAB r       python-remove-import
  ;; C-c TAB s       python-sort-imports
  ;;
  ;; И это мешает повесить автокомплит на привычный мне C-c TAB.
  (unless *40wt/python-mode-keys-remapped*
    (keymap-set python-mode-map "C-c TAB a" nil)
    (keymap-set python-mode-map "C-c TAB f" nil)
    (keymap-set python-mode-map "C-c TAB r" nil)
    (keymap-set python-mode-map "C-c TAB s" nil)
    
    (keymap-set python-mode-map "C-c TAB" 'completion-at-point)

    (setf *40wt/python-mode-keys-remapped* t)))


(add-hook 'python-mode-hook #'40ants-remap-python-mode-keys)


(use-package lsp-mode
  :ensure t
  :hook python-mode python-ts-mode
  :commands lsp
  :custom
  (lsp-pylsp-server-command (list "pylsp" "--verbose" "--log-file" "/tmp/pylsp.log"))
  
  (lsp-pylsp-plugins-ruff-line-length 120)
  (lsp-pylsp-plugins-ruff-executable (string-trim
                                      (shell-command-to-string
                                       "/codenv/arcadia/ya tool ruff --print-path")))
  (lsp-pylsp-plugins-flake8-enabled nil)
  (lsp-pylsp-plugins-ruff-enabled t))


(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (keymap-set global-map "M-p" 'flycheck-previous-error)
  (keymap-set global-map "M-n" 'flycheck-next-error))


;; This plugin works together with Powerline-mode,
;; coloring file name in the mode line into different
;; colors depending on number errors or warnings
(use-package flycheck-color-mode-line
  :ensure t
  :after flycheck
  :hook flycheck-mode)


(use-package python-pytest
  :ensure t
  :after lsp-mode
  :config
  (keymap-set lsp-command-map "t" 'python-pytest-dispatch))


(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  (treesit-auto-langs '(python))
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))


(use-package hideshowvis
  :ensure t)

(use-package folding
  :ensure t)

;; (use-package ts-fold
;;   :straight (ts-fold :type git :host github :repo "emacs-tree-sitter/ts-fold"))
