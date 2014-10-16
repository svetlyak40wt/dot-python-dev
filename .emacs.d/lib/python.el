;; для использования elpy, надо установить python модули:
;; pip install elpy jedi rope

(require 'package)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))


;; elpy-enable должен быть запущен до загрузки python кода,
;; поэтому делаем это не в хуке, а прямо тут
(use-packages '(elpy))
(elpy-enable)
(setq elpy-rpc-backend "jedi")

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
       (local-set-key (kbd "C-c i") 'iedit-mode)
  
       ;; подсвечиваем брекпоинты, чтобы не забыть их удалить
       ;; это включает hi-lock minor mode
       (highlight-lines-matching-regexp "pdb\.set_trace" "hi-blue")

       ;; Turn on automatic syntax checker
       ;; https://github.com/purcell/flymake-python-pyflakes
       (require 'flymake-python-pyflakes)
       (flymake-python-pyflakes-load)
       (flymake-cursor-mode))

     
     (add-hook 'python-mode-hook 'python-config)))

