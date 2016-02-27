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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; packages, archives, reqd packages, i.e. important stuff gets loaded first
;; (load "~/.emacs.d/my-packages.el")
;(load "/home/edward/DEV/EMACS/my-packages.el")
;;
;; (setf custom-file "~/.emacs.d/custom.el")
;(setf custom-file "/home/edward/DEV/EMACS/custom.el")
;(load custom-file)

;;
;; (load "~/.emacs.d/my-modes.el")
;(load "/home/edward/DEV/EMACS/my-modes.el")
;; mode line customization takes place last
;; (load "~/.emacs.d/my-modeline.el")
(load "/home/edward/DEV/EMACS/my-modeline.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NB
;; ---- debug mode in windows and linux, e.g. debug the .emacs file
;; C:\bin> emacs .emacs --debug-init
;; $ emacs .emacs --debug-init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
