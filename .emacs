;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ~/.emacs
;;
;;
;;  DEPENDENCIES:
;;    ~/.emacs.d/custom.el
;;    ~/.emacs.d/my-packages.el
;;    ~/.emacs.d/my-modes.el
;;    ~/.emacs.d/my-modeline.el
;;
;;
;;  USE:  Place .emacs in your home directory (~/)
;;        Place dependencies in ~/.emacs.d/
;;
;;  TODOs:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setf user-full-name "Edward Glidewell")
;; (setf user-mail-address "edwardglidewell@gmail.com")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)

(setq hostname
    (replace-regexp-in-string "\\`[ \t\n]*" ""
    (replace-regexp-in-string "[ \t\n]*\\'" ""
    (shell-command-to-string "hostname"))))

(defun display-startup-echo-area-message ()
    (message  ".emacs loaded on %s " hostname))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define LoadPath
(add-to-list 'load-path "~/DEV/EMACS/")
;;(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Load req'd packages, package repositories i.e. load important stuff first

(load "/home/edward/DEV/EMACS/my-packages.el")
;(load "/home/edward/DEV/EMACS/my-modes.el")
;(load "/home/edward/DEV/EMACS/my-modeline.el")

;(require 'my-packages)


;; (load "~/.emacs.d/my-modes.el")
;(require 'my-modes)


;;(setf custom-file "~/.emacs.d/custom.el")
;(setf custom-file "/home/edward/DEV/EMACS/custom.el")
;(load custom-file)

;; mode line customization takes place last
;; (load "~/.emacs.d/my-modeline.el")
;(require 'my-modeline)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NB
;; ---- debug mode in windows and linux, e.g. debug the .emacs file
;; C:\bin> emacs .emacs --debug-init
;; $ emacs .emacs --debug-init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
