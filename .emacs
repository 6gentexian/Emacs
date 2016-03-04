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
(setf user-full-name "Edward Glidewell")
(setf user-mail-address "edwardglidewell@gmail.com")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;(defun display-startup-echo-area-message ()
;  (message ".emacs loaded successfully."))

;(defvar current-hostname
;  (or (getenv "HOSTNAME") (getenv "COMPUTERNAME") "unknown")
;  "hostname of this machine")

;(setq current-hostname (getenv "HOSTNAME"))
;  (display-message "$HOSTNAME depth is %s."
;  (current-hostname))    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load req'd packages, package repositories i.e. load important stuff first
;;(load "~/.emacs.d/my-packages.el")
;(load "/home/edward/DEV/EMACS/my-packages.el")




;;
;; (load "~/.emacs.d/my-modes.el")
;(load "/home/edward/DEV/EMACS/my-modes.el")

;;(setf custom-file "~/.emacs.d/custom.el")
;(setf custom-file "/home/edward/DEV/EMACS/custom.el")
;(load custom-file)

;; mode line customization takes place last
;; (load "~/.emacs.d/my-modeline.el")
;(load "/home/edward/DEV/EMACS/my-modeline.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NB
;; ---- debug mode in windows and linux, e.g. debug the .emacs file
;; C:\bin> emacs .emacs --debug-init
;; $ emacs .emacs --debug-init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
