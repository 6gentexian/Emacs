;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; TODO: Confirm whitespace cleanup so that copy/paste doesn't get wonky
;;       with the crazy indentations
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NEEDED TO GET ENABLE MOUSE TO SET ACTIVE REGION
(require 'mouse)
(xterm-mouse-mode t)

;; Turn on auto complete.
(require 'auto-complete-config)
(ac-config-default)


;; NOW NEEDED (EMACS >=24) TO ENABLE MOUSE MIDDLE BUTTON TO COPY/PASTE IN AND OUT
;;  OF EMACS
(setq select-active-regions nil)
(setq mouse-drag-copy-region t)
(global-set-key [mouse-2] 'mouse-yank-at-click)


;; CAN NOW PASTE TO /COPY FROM WINDOWS
(setq x-select-enable-clipboard t)


;; USE BUGGERY TO MAKE THINGS WORK LIKE THEY USED TO IN EMACS <=23
(unless window-system
 (when (getenv "DISPLAY")
   ; Callback for when user cuts
   (defun xsel-cut-function (text &optional push)
     ; Insert text to temp-buffer, and "send" content to xsel stdin
     (with-temp-buffer
    (insert text)

    (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    ;Call back for when user pastes
   (defun xsel-paste-function()

     (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
    (unless (string= (car kill-ring) xsel-output)
      xsel-output )))
    ;Attach callbacks to hooks
   (setq interprogram-cut-function 'xsel-cut-function)
   (setq interprogram-paste-function 'xsel-paste-function)
))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This makes sure that brace structures (), [], {}, etc. are closed as soon as
;;  the opening character is typed.
(show-paren-mode t)
(setq-default show-paren-delay 0)
(setq-default scroll-step 1)

;;Typing 'yes' or 'no' in prompts is tiring. Instead use 'y'/'n' keys at prompts:
(defalias 'yes-or-no-p 'y-or-n-p)

;; Turn down the time to echo keystrokes so I don't have to wait around
(setq echo-keystrokes 0.1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; make sure file ends with newline
(setq-default require-final-newline t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode -1)
;; display time in the modeline
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs usually has a splash screen on startup.
;; Get rid of that and start with a blank buffer.
(setq  inhibit-startup-message t
       inhibit-splash-screen t
       inhibit-startup-echo-area-message t)

(setq hostname
  (replace-regexp-in-string "\\`[ \t\n]*" ""
  (replace-regexp-in-string "[ \t\n]*\\'" ""
  (shell-command-to-string "hostname"))))

(defun display-startup-echo-area-message ()
  (message  ".emacs loaded on %s " hostname))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Set encoding
(setq  prefer-coding-system 'utf-8)
(setq  coding-system-for-read 'utf-8)
(setq  coding-system-for-write 'utf-8)

;; make the default appearance side by side windows instead of vertically stacked
(setq  split-height-threshold 0)
(setq  split-width-threshold nil)

;; Column line where text should be wrapped
(setq  fill-column 80)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Switch buffers w/o having to give an 'OK'
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer t t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
(global-set-key (kbd "C-x C-r") 'query-replace-regexp)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [f1] "\C-x3")  ;; Split vert
(global-set-key [f2] "\C-x2")  ;; Split horiz
(global-set-key [f3] 'goto-line)
(global-set-key [f5] 'revert-buffer-no-confirm)

(global-set-key (kbd "C-x 1") 'delete-window)
(global-set-key (kbd "C-x 0") 'delete-other-windows)

(global-set-key (kbd "C-x f") (lambda ()
                (interactive)
                (other-window -1)))  ;; back one
(global-set-key (kbd "C-<tab>") (lambda ()
                  (interactive)
                  (other-window 1))) ;; forward one

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fullscreen editing
(defun fullscreen ()
  (interactive)
    (set-frame-parameter nil 'fullscreen
    (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f12] 'fullscreen)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BLOCK COMMENTING CODE
(defun comment-dwim-line (&optional arg)
    "Replacement for the comment-dwim command.
    If no region is selected and current line is not blank and we are not at
    the end of the line, then comment current line.
    Replaces default behaviour of comment-dwim, when it inserts comment at the
    end of the line."
    (interactive "*P")
    (comment-normalize-vars)
    (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
      (comment-dwim arg)))

(global-set-key "\M-;" 'comment-dwim-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst win32
  (eq system-type 'windows-nt)
  "Are we running on Win32 system")

(defconst linux
  (eq system-type 'gnu/linux)
  "Are we running on linux system")

;; places top left corner of initial frame at location (x,y) on screen
(when win32
  ;; size & position
  (setq initial-frame-alist
    '(;
      (top               . 20)
      (left             . 300)
    )
  )

  ;; Display settings
  ; default size and color options for all frames.
  (setq default-frame-alist
   '(
      (width             . 100)
      (height            . 50)
    )
  )
  (cd "C:/Dropbox/")
)

(when linux
  ;; size & position
  (setq initial-frame-alist
    '(;
      (top               . 20);
      (left             . 800);
    )
  )

  ;; Display settings
  ; default size and color options for all frames.
  (setq default-frame-alist
    '(
       (width             . 130)
       (height            . 65)
    )
    )
  (set-face-attribute 'default nil :height 100)
  (cd "~/")
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; /usr/share/emacs/24.5/etc/themes
(load-theme 'tango-dark t)

;; Nertz bollocky bell!!!
(setf visible-bell t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CLEAN UP WHITE SPACES FROM COPY/PASTE ETC
(add-hook 'before-save-hook 'whitespace-cleanup)
;; Belt and suspenders
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default show-trailing-whitespace t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; make backup to a designated dir, mirroring the full path
(setq
  backup-by-copying t                     ; don't clobber symlinks
  backup-directory-alist
  '(("." . "~/.emacs.d/emacs-backup"))    ; don't litter my fs tree
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 4
  version-control t)                      ; use versioned backups

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Open file at the last place where it was when you previously saved the file
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
