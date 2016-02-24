;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ~/.emacs.d/my-packages.el
;(require 'cl-lib)
;; If you need Common Lisp extensions, use the cl-lib library rather than the old
;;  cl library. The latter does not use a clean namespace (i.e., its definitions
;;  do not start with a ‘cl-’ prefix). If your package loads cl at run time, that
;;  could cause name clashes for users who don't use that package.
;; There is no problem with using the cl package at compile time, with
;;  (eval-when-compile (require 'cl)). That's sufficient for using the macros in
;;  the cl package, because the compiler expands them before generating the
;;  byte-code. It is still better to use the more modern cl-lib, though.
;; So please require cl-lib, not cl !!!
;; source: http://www.emacswiki.org/emacs/CommonLispForEmacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; needed to read packages from 'elpa', ~/.emacs.d/elpa
(require 'package)


(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
;(add-to-list 'package-archives
;             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (not package-archive-contents)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If at some point, I have a bunch of non-built-in packages to work with
(defvar ebg-packages
  '(
    auctex
    ess
    autopair
    ac-R
    python-mode
    zenburn-theme
    auto-complete-auctex
    ))

(dolist (pkg ebg-packages)
  (when (and (not (package-installed-p pkg))
           (assoc pkg package-archive-contents))
    (package-install pkg)))

(defun package-list-unaccounted-packages ()
;;  "Like `package-list-packages', but shows only the packages that
;;  are installed and are not in `ebg-packages'.  Useful for
;;  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x ebg-packages))
                            (not (package-built-in-p x))
                            (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TO BE USED WHEN CONFIGURING NEW MACHINE
;; (require 'cl)

;; ;; method to check if all packages are installed
;; (defun packages-installed-p ()
;;   (loop for pkg in ebg-packages
;;         when (not (package-installed-p pkg)) do (return nil)
;;         finally (return t)))

;; ;; if not all packages are installed, check one by one and install the missing ones.
;; (unless (packages-installed-p)
;;   ;; check for new packages (package versions)
;;   (message "%s" "Emacs is now refreshing its package database...")
;;   (package-refresh-contents)
;;   (message "%s" " done.")
;;   ;; install the missing packages
;;   (dolist (pkg ebg-packages)
;;     (when (not (package-installed-p pkg))
;;       (package-install pkg))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

