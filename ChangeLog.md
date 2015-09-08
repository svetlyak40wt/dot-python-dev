0.3.0 (2015-09-07)
==================

* Don't activate yasnippets on the python level. Now it
  is activated by emacs main config directly.

0.2.2 (2015-04-23)
==================

* Fixed loading of emacs config. It was broken because flymake-cursor-mode function is absent in flymake-cursor.el.

0.2.1 (2015-02-11)
==================

* Fixed `column-enforce-mode` setup.

0.2.0
=====

* Use `column-enforce-mode` to highlight long lines.
* Highlight not only `pdb.set_trace()`, but any line
  containing `.set_trace()`.

0.1.0
=====

* Bind "C-c g" to magit-status.
* Add config and light solarized theme for [pudb][]. Color theme is compatible with iTerm2's light solarized theme.

[pudb]: https://pypi.python.org/pypi/pudb
