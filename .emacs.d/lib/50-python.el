;; для использования elpy, надо установить python модули:
;; pip install elpy jedi rope

(require 'package)

;; Начиная с версии 1.18.0 elpy стали раздавать через MELPA stable.
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/"))


;; elpy-enable должен быть запущен до загрузки python кода,
;; поэтому делаем это не в хуке, а прямо тут
(use-packages '(elpy))
(elpy-enable)
(setq elpy-rpc-backend "jedi")

 
(defun reformat-test-name (&optional arg)
  "Эта функция превращает строку с описанием теста типа
test_set_signature (test.test_settings.TestSettings)
в
test.test_settings:TestSettings.test_set_signature
"
  (interactive "p")
  (kmacro-exec-ring-item
   (quote ([67108896 19 32 return left 24 11 5 backspace 46 25 18 92 46 18 return 4 58 1 4 4 14] 0 "%d"))
   arg))


;; (when (executable-find "ipython")
;;   (setq python-shell-interpreter "ipython")
;;   (setq python-shell-interpreter-args "--pylab"))

(eval-after-load 'python
  `(progn
     (defun python-config ()
       (use-packages '(;; дополнение символов, которые используются
                       ;; в текущем файле
                       auto-complete
                       ;; подсказки неправильного синтаксиса и импортов
                       flymake-python-pyflakes
                       flymake-cursor
                       ;; выделение окружающего контекста по C-c =
                       expand-region
                       ;; выделение строк, которые выбиваются за
                       ;; границу в 80 символов
                       column-enforce-mode
                      ))

       ;; To make right indent after if/for/etc tokens
       (local-set-key (kbd "RET") 'newline-and-indent)
       ;; Nothing on this shortcut
       (local-set-key (kbd "C-c n") 'flymake-goto-next-error)
       (local-set-key (kbd "C-c i") 'iedit-mode)

       ;; Чтобы прыгать обратно на место откуда делался поиск тега, как в Lisp
       ;; по умолчанию, это было забинжено на M-*, что неудобно нажимать
       ;; А на M-, по умолчанию висело tags-loop-continue, что я никогда не исользую.
       (local-set-key (kbd "M-,") 'pop-tag-mark)

       ;; To delete trailing whitespaces on save
       (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)
  
       ;; подсвечиваем брекпоинты, чтобы не забыть их удалить
       ;; это включает hi-lock minor mode
       (highlight-lines-matching-regexp "\.set_trace" "hi-blue")

       ;; Turn on automatic syntax checker
       ;; https://github.com/purcell/flymake-python-pyflakes
       (require 'flymake-python-pyflakes)
       (flymake-python-pyflakes-load)
       (column-enforce-mode))
     
     (add-hook 'python-mode-hook 'python-config)))


