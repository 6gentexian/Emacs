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

;;(add-to-list 'load-path "/usr/share/emacs/site-lisp/ess/")
;;(load "ess-site")
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
	 ("\\.r\\'" . sh-mode))
       auto-mode-alist))


(add-hook 'text-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (setq tab-width 4)
	     (setq indent-line-function (quote insert-tab))))

;;Handling Uncommon File Extensions
;(add-to-list 'auto-mode-alist '("\\.ext\\'" . text-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.ppl\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.pyw\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.pyc\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'"  . python-mode))
(add-to-list 'auto-mode-alist '("\\.wsgi$"  . python-mode))

;; (setq python-indent 4)
;; (add-hook 'python-mode-hook 'color-identifiers-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes
;;
;; JavaScript Mode
;; js-mode defaults to using 4 spaces for indentation. Change it to 2
(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2))

(add-hook 'js-mode-hook 'js-custom)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; Red Warnings
;; ;; Various keywords (in comments) are now flagged in a Red Error font:
;; (add-hook 'prog-common-hook
;;	  (lambda ()
;;	    (font-lock-add-keywords nil
;;    '(("\\<\\(FIX\\|FIXME\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((R . t)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
