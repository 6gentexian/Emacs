;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-modes.el
;; Info corresponding to setting and configuring modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auctex
;; Invoke the AUCTeX package (LaTeX support)
(require 'tex-site)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ESS
(require 'ess-site)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FILE EXTENSIONS -> ACTIVATE VARIOUS MAJOR MODES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq default-major-mode 'emacs-lisp-mode)

;; if first line of file matches, activate text-mode ? sh-mode??
(add-to-list 'magic-mode-alist '("#!/bin/bash". emacs-lisp-mode))

(setq auto-mode-alist
      (append
       ;; File name (within directory) starts with a dot.
       '(("/\\.[^/]*\\'" . emacs-lisp-mode)
	 ;; File name has no dot.
	 ("/[^\\./]*\\'" . emacs-lisp-mode)
	 ;; File name ends in ‘.C’.
	 ("\\.C\\'" . c++-mode)
	 ("\\.c\\'" . c-mode)
	 ("\\.h\\'" . c-mode)
	 ;; emacs file ftw
	 ("\\.el\\'" . emacs-lisp-mode)
	 ("\\.R\\'" . sh-mode)
	 ("\\.r\\'" . sh-mode)
	 ("\\.txt$" . org-mode)
	 ("\\.bib$" . org-mode)
	 )
       auto-mode-alist))


;; (add-hook 'text-mode-hook
;;	  '(lambda ()
;;	     (setq indent-tabs-mode nil)
;;	     (setq tab-width 4)
;;	     (setq indent-line-function (quote insert-tab))))

;; ;;Handling Uncommon File Extensions
;; (add-to-list 'auto-mode-alist '("\\.ext\\'" . text-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Python mode settings
(require 'python-mode)

;(setq python-indent 4)
;(add-hook 'python-mode-hook 'color-identifiers-mode))
(add-hook 'python-mode-hook 'autopair-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.ppl\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.pyw\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.pyc\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'"  . python-mode))
(add-to-list 'auto-mode-alist '("\\.wsgi$"  . python-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes
;;
;; JavaScript Mode
;; js-mode defaults to using 4 spaces for indentation. Change it to 2
(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 4))

(add-hook 'js-mode-hook 'js-custom)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Red Warnings
;; Various keywords (in comments) are now flagged in a Red Error font:
(add-hook 'prog-common-hook
	  (lambda ()
	    (font-lock-add-keywords nil
   '(("\\<\\(FIX\\|FIXME\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((R . t)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Turn on auto complete.
(require 'auto-complete-config)
(ac-config-default)

;(global-auto-complete-mode)
;(eval-after-load "auto-complete"
;  '(add-to-list 'ac-modes '(geiser-repl-mode geiser-mode) t))

(require 'flycheck)
;; (global-flycheck-mode t)
;; (add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)

(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'web-mode-hook 'flyspell-mode)

(add-hook 'c++-mode-hook 'flyspell-mode)
(add-hook 'c-mode-hook 'flyspell-mode)

(add-hook 'emacs-lisp-mode-hook 'flyspell-mode -1)
(add-hook 'python-mode-hook 'flyspell-mode)

(add-hook 'sh-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-mode)

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))


;; (defun TeX-input-method () (set-input-method 'TeX))
;;   (add-hook 'org-mode-hook 'TeX-input-method)
;;   (add-hook 'markdown-mode-hook 'TeX-input-method)
;;   (add-hook 'latex-mode-hook 'TeX-input-method)
