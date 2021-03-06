;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ~/.emacs
;;
;;
;;  DEPENDENCIES:
;;    ~/.emacs.d/lisp/custom.el
;;    ~/.emacs.d/lisp/my-packages.el
;;    ~/.emacs.d/lisp/my-modes.el
;;    ~/.emacs.d/lisp/my-modeline.el
;;
;;
;;  USE:  Place .emacs in your home directory (~/)
;;        Place dependencies in ~/.emacs.d/
;;
;;  TODOs:
;;
;;  NB
;;    ---- debug mode in windows and linux, e.g. debug the .emacs file
;;    C:\bin> emacs .emacs --debug-init
;;    $ emacs .emacs --debug-init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Define LoadPath -- get things setup to download and install packages
(add-to-list 'load-path "~/.emacs.d/lisp")


;; Load req'd packages, package repositories; i.e. load important stuff first
(require 'my-packages)

;; Customize config per mode
(require 'my-modes)

;; All user configs not related to anything else here...
(setf custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)

;; mode line customization takes place last
;;(require 'my-modeline)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
