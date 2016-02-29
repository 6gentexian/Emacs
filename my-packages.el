;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ~/.emacs.d/my-packages.el
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Needed to read packages from local package repo, 'elpa':   ~/.emacs.d/elpa
(require 'package)

(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;;(add-to-list 'package-archives
;;	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (not package-archive-contents)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TO BE USED WHEN CONFIGURING NEW MACHINE
;;
;; I have a bunch of non-built-in packages to work with --
;; (defvar required-packages
;;   '(
;;     auctex
;;     ess
;;     autopair
;;     ac-R
;;     python-mode
;;     zenburn-theme
;;     auto-complete-auctex
;;     ac-html
;;     ac-html-csswatcher
;;     ac-ispell
;;     ac-math
;;     ac-python
;;     ac-ispell
;;     auto-complete-pcmp
;;     concurrent
;;     ctable
;;     dash
;;     deferred
;;     epc
;;     f
;;     flyspell-popup
;;     js2-mode
;;     ac-js2
;;     julia-mode
;;     log4e
;;     math-symbol-lists
;;     org-mode
;;     org-ac
;;     popup
;;     rw-ispell
;;     s
;;     web-mode
;;     web-completion-data
;;     yasnippet
;;     yaxception
;;   )
;;  "List of packages installed at launch.")
;; )

;; ;; method to check if all packages are installed
;; (defun packages-installed-p ()
;;   (loop for pkg in required-packages
;;         when (not (package-installed-p pkg)) do (return nil)
;;         finally (return t)))
;; ;; if all packages are not installed, check one by one and install the missing ones.
;; (unless (packages-installed-p)
;;   ;; check for new packages (package versions)
;;   (message "%s" "Emacs is now refreshing its package database...")
;;   (package-refresh-contents)
;;   (message "%s" " done.")
;;   ;; install the missing packages
;;   (dolist (pkg required-packages)
;;     (when (not (package-installed-p pkg))
;;       (package-install pkg))))

;; (defun package-list-unaccounted-packages ()
;; ;;  "Like `package-list-packages', but shows only the packages that
;; ;;  are installed and are not in `required-packages'.  Useful for
;; ;;  cleaning out unwanted packages."
;;   (interactive)
;;   (package-show-package-list
;;    (remove-if-not (lambda (x) (and (not (memq x required-packages))
;;			    (not (package-built-in-p x))
;;			    (package-installed-p x)))
;;		  (mapcar 'car package-archive-contents))))

;; (provide 'my-packages)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (dolist (pkg required-packages)
;;   (when (and (not (package-installed-p pkg))
;;	   (assoc pkg package-archive-contents))
;;     (package-install pkg)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
