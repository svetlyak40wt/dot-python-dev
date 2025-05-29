(defvar *40wt/python-mode-keys-remapped* nil)

(defvar *40wt/python-ts-mode-keys-remapped* nil)

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


(defun 40ants-remap-python-ts-mode-keys ()
  (unless *40wt/python-ts-mode-keys-remapped*
    (keymap-set python-ts-mode-map "C-c TAB a" nil)
    (keymap-set python-ts-mode-map "C-c TAB f" nil)
    (keymap-set python-ts-mode-map "C-c TAB r" nil)
    (keymap-set python-ts-mode-map "C-c TAB s" nil)
    
    (keymap-set python-ts-mode-map "C-c TAB" 'completion-at-point)
    (setf *40wt/python-ts-mode-keys-remapped* t)))

(add-hook 'python-ts-mode-hook #'40ants-remap-python-ts-mode-keys)


(use-package lsp-mode
  :ensure t
  :hook python-mode python-ts-mode
  :commands lsp
  :custom
  ;; (lsp-pylsp-server-command (list "pylsp" "-vv" "--log-file" "/tmp/pylsp.log"))
  
  (lsp-pylsp-server-command (list "/home/art/python-lsp-server/.venv/bin/pylsp" "-vv" "--log-file" "/tmp/pylsp.log"))
  ;; (lsp-pylsp-server-command (list "/usr/bin/python" "-m" "pylsp" "-vv" "--log-file" "/tmp/pylsp.log"))
  
  (lsp-pylsp-plugins-ruff-line-length 120)
  (lsp-pylsp-plugins-ruff-executable (string-trim
                                      (shell-command-to-string
                                       "/codenv/arcadia/ya tool ruff --print-path")))

  ;; Без установки python модуля pylsp-mypy не работает проверка типов и сигнатур функций.
  (lsp-pylsp-plugins-mypy-enabled t)
;;  (lsp-pylsp-plugins-mypy-report-progress t)
;;  (lsp-pylsp-plugins-mypy-config-sub-paths (list "/codenv/arcadia/taxi/dmp/dwh"))
  (lsp-pylsp-plugins-pylint-enabled t)
  (lsp-pylsp-plugins-pylint-executable "/codenv/arcadia/taxi/dmp/dwh/.env3/bin/pylint")
  (lsp-pylsp-plugins-pylint-args (list "--rcfile" "/codenv/arcadia/taxi/dmp/dwh/tools/config/pylint/universal-rcfile"))


  (lsp-file-watch-threshold 50000)
  
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
