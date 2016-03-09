;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ~/.emacs.d/my-packages.el
;;
;;  TODOs:  Get rest of packages installed as soon as we figger out how
;;          to get spell checker loading at launch, as per mode
;;          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Needed to read packages from local package repo, 'elpa':   ~/.emacs.d/elpa
(add-to-list 'load-path "~/DEV/EMACS/elpa/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;;(add-to-list 'package-archives
;;           '("melpa-stable" . "https://stable.melpa.org/packages/") t)


(defvar required-packages
  '(auctex
    auto-complete
    auto-complete-auctex
    ess
    ess-R-object-popup
    autopair
    python-mode
    log4j-mode
    org
    org-ac
    org-beautify-theme
    org-dashboard
    org-plus-contrib
    ac-python
    ac-ispell
    ac-js2
    web-mode
    )
  "List of packages installed at launch."
  )

(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package required-packages)
  (unless (package-installed-p package)
        (package-install package)))

    ;; concurrent
    ;; ctable
    ;; dash
    ;; deferred
    ;; epc
    ;; f
    ;; flycheck
    ;; flyspell-popup
    ;; julia-mode
    ;; math-symbol-lists
    ;; rw-ispell
    ;; s
    ;; ac-html
    ;; ac-html-csswatcher
    ;; ac-math
;; "Remaining list of packages to install."
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'my-packages)
