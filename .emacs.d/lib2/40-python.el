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


(use-package pytest
  :custom
  ((pytest-project-root-files '("service.yaml" "setup.py" ".hg" ".git")))
  :config
  (keymap-set python-mode-map "C-t o" 'pytest-one)
  (keymap-set python-mode-map "C-t a" 'pytest-again)
  (keymap-set python-mode-map "C-t A" 'pytest-all)
  (keymap-set python-mode-map "C-t m" 'pytest-module))
