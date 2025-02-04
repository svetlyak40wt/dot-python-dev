(defun 40ants-remap-python-mode-keys ()
  ;; В python-mode С-с TAB является префиксом для таких команд:
  ;;
  ;; C-c TAB a       python-add-import
  ;; C-c TAB f       python-fix-imports
  ;; C-c TAB r       python-remove-import
  ;; C-c TAB s       python-sort-imports
  ;;
  ;; И это мешает повесить автокомплит на привычный мне C-c TAB.
  (keymap-set python-mode-map "C-c TAB a" nil)
  (keymap-set python-mode-map "C-c TAB f" nil)
  (keymap-set python-mode-map "C-c TAB r" nil)
  (keymap-set python-mode-map "C-c TAB s" nil)
  (keymap-set python-mode-map "C-c TAB" 'completion-at-point))


(add-hook 'python-mode-hook #'40ants-remap-python-mode-keys)


(use-package lsp-mode
  :hook (python-mode lsp)
  :commands lsp)


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


(defun 40wt/pytest-one (&optional arg)
  (interactive "P")
  (if arg
      (pytest-pdb-one)
    (pytest-one)))


(use-package pytest
  :custom
  ((pytest-project-root-files '("service.yaml" "setup.py" ".hg" ".git")))
  :config
  (keymap-set python-mode-map "C-t o" '40wt/pytest-one)
  (keymap-set python-mode-map "C-t a" 'pytest-again)
  (keymap-set python-mode-map "C-t A" 'pytest-all)
  (keymap-set python-mode-map "C-t m" 'pytest-module))


(defun 40wt/pytest-again-with-sql-regen ()
  ;; Changes a command like this
  ;; cd '/codenv/arcadia/taxi/backend-py3/services/dmp-sched/' && /codenv/arcadia/taxi/backend-py3/runtests -x -s ''/codenv/arcadia/taxi/backend-py3/services/dmp-sched/test_dmp_sched/cron/test_job_manager.py::test_scheduling_attempt''

  (if-let* ((last-command (gethash (pytest-get-temp-buffer-name) pytest-last-commands))
            (command (replace-regexp-in-string "&&"
                                               "&& /codenv/arcadia/ya tool tt gen -p services/dmp-sched --plugins sqlt postgres_queries &&"
                                               last-command)))
      (pytest-start-command command)
    (error "Pytest has not run before")))


;; https://github.com/emacsmirror/importmagic
;; To make it work, do pip install importmagic epc
(use-package importmagic
  :ensure t
  :hook python-mode
  :config
  (keymap-set importmagic-mode-map "C-c C-l" 'importmagic-fix-symbol-at-point))
