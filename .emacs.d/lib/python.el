(eval-after-load 'python
  `(progn
     (defun python-config ()
       (use-packages '(;; дополнение символов, которые используются
                       ;; в текущем файле
                       auto-complete
                       ;; использование сниппетов
                       yasnippet
                       ;; подсказки неправильного синтаксиса и импортов
                       flymake-python-pyflakes
                       flymake-cursor
                       ;; выделение окружающего контекста по C-c =
                       expand-region
                      ))

       ;; To make right indent after if/for/etc tokens
       (local-set-key (kbd "RET") 'newline-and-indent)
       ;; Nothing on this shortcut
       (local-set-key (kbd "C-c n") 'flymake-goto-next-error)
  
       ;; activate snippets
       (yas-minor-mode)

;       (setq jedi:setup-keys t)

       ;; включаем простой автокомплит
       (require 'auto-complete)
       (auto-complete-mode)

       ;; подсвечиваем брекпоинты, чтобы не забыть их удалить
       (highlight-lines-matching-regexp "pdb\.set_trace" "hi-blue")
;       (jedi:setup)

       ;; Turn on automatic syntax checker
       ;; https://github.com/purcell/flymake-python-pyflakes
       (require 'flymake-python-pyflakes)
       (flymake-python-pyflakes-load))

     
     (add-hook 'python-mode-hook 'python-config)))
