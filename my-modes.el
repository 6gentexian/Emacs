;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-modes.el
;;
;;
;; Info corresponding to setting and configuring modes
;;
;; Is it me, or are some of these settings chronically wonky??
;;
;;  TODO: get abrev-mode working for auctex
;;        try and set custom tabs n text-mode
;;        add custom comment symbol for each kind of mode type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; sample files/type
;; /home/edward/TMP/test.ext
;; /home/edward/TMP/nscpmsg.txt
;; /home/edward/TMP/xsel.log
;; /home/edward/TMP/dataTest.py
;; /home/edward/TMP/cv-1-short.html
;; /home/edward/TMP/CV_Master.tex
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Set autopair and auto-comlpete globally
(require 'autopair)
(autopair-global-mode)

;; Auctex
;; Invoke the AUCTeX package (LaTeX support)
(require 'tex-site)

;; To compile documents to PDF (via PDFLaTeX) by default add the following to your ~/.emacs.
;;(setq TeX-PDF-mode t)

;; If it doesn’t work, try
;; (require 'tex)
;; (TeX-global-PDF-mode t)

;; By default, AUCTeX shares its abbreviations with the major mode text-mode.
;; This means that abbreviations saved with C-x a l (add-mode-abbrev) are
;; saved in the table text-mode-abbrev-table and become available in all buffers
;; using text-mode. This may not be the expected behavior.
;; Here is how to define abbreviations that work in auctex modes only,
;; without interfering with the standard text-mode. In the InitFile, put:
;; (define-abbrev-table 'TeX-mode-abbrev-table (make-abbrev-table))
;; (add-hook 'TeX-mode-hook (lambda ()
;;    (setq abbrev-mode t)
;;    (setq local-abbrev-table TeX-mode-abbrev-table)))
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
     ("\\.R\\'" . R-mode)
     ("\\.r\\'" . R-mode)
     ("\\.txt$" . text-mode)
     ("\\.ext$" . prog-mode)
     ("\\.tmp$" . text-mode)
     ("\\.html$" . web-mode)
     ("\\.log$" . log-view-mode)
     ("\\.tex$" . latex-mode)
     ("\\.bib$" . org-mode)
     )
       auto-mode-alist)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-add-to-multiple-hooks (function hooks)
  (mapc (lambda (hook)
      (add-hook hook function))
    hooks))

(defun my-tabs-to-space-indent-4 ()
  (setq tab-width 4)
  (setq tab-stop-list (number-sequence 4 200 4))
  (setq indent-tabs-mode nil))

(my-add-to-multiple-hooks
 'my-tabs-to-space-indent-4
 '(text-mode-hook
   prog-mode-hook
   log-mode-hook
   python-mode-hook
   emacs-lisp-mode-hook))
;   org-mode-hook))  // no effect
;  // R-mode defaults to 2 - can't seem to change it...?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes
;;
;; Python mode settings
;;
(require 'python-mode)

(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-to-list 'auto-mode-alist '("\\.pyx\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.ppl\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.pyw\\'" . python-mode))

(add-to-list 'auto-mode-alist '("\\.pyc\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'"  . python-mode))
(add-to-list 'auto-mode-alist '("\\.wsgi$"  . python-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JavaScript Mode
;;
;; js-mode defaults to using 4 spaces for indentation. Change it to 2
(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2))

(add-hook 'js-mode-hook 'js-custom)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Red Warnings in the top comment section
;; Various keywords (in comments) are now flagged in a Red Error font:
(add-hook 'text-mode-hook
  (lambda ()  (font-lock-add-keywords nil
  '(("\\<\\(FIX\\|FIXME\\|TODOs\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
(add-hook 'prog-mode-hook
  (lambda ()  (font-lock-add-keywords nil
  '(("\\<\\(FIX\\|FIXME\\|TODOs\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
(add-hook 'log4j-mode-hook
  (lambda ()  (font-lock-add-keywords nil
  '(("\\<\\(FIX\\|FIXME\\|TODOs\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
(add-hook 'python-mode-hook
  (lambda ()  (font-lock-add-keywords nil
  '(("\\<\\(FIX\\|FIXME\\|TODOs\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
(add-hook 'R-mode-hook
  (lambda ()  (font-lock-add-keywords nil
  '(("\\<\\(FIX\\|FIXME\\|TODOs\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
(add-hook 'latex-mode-hook
  (lambda ()  (font-lock-add-keywords nil
  '(("\\<\\(FIX\\|FIXME\\|TODOs\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
(add-hook 'emacs-lisp-mode-hook
  (lambda ()  (font-lock-add-keywords nil
  '(("\\<\\(FIX\\|FIXME\\|TODOs\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
(add-hook 'org-mode-hook
  (lambda ()  (font-lock-add-keywords nil
  '(("\\<\\(FIX\\|FIXME\\|TODOs\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((R . t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Turn on auto complete.
(require 'auto-complete-config)
(ac-config-default)

(global-auto-complete-mode)
(eval-after-load "auto-complete"
 '(add-to-list 'ac-modes '(geiser-repl-mode geiser-mode) t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'flycheck)

(require 'flyspell)

(setq flyspell-sort-corrections nil)
(setq flyspell-doublon-as-error-flag nil)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'org-mode-hook 'turn-on-flyspell)


(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)

(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

;; (add-hook 'markdown-mode-hook 'flyspell-mode)
;; (add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'web-mode-hook 'flyspell-mode)
;; (add-hook 'emacs-lisp-mode-hook 'flyspell-mode -1)
;; (add-hook 'sh-mode-hook 'flyspell-mode)

(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; (defun TeX-input-method () (set-input-method 'TeX))
;;   (add-hook 'org-mode-hook 'TeX-input-method)
;;   (add-hook 'markdown-mode-hook 'TeX-input-method)
;;   (add-hook 'latex-mode-hook 'TeX-input-method)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'my-modes)
