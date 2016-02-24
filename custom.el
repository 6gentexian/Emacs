;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NEEDED TO GET ENABLE MOUSE TO SET ACTIVE REGION
(require 'mouse)
(xterm-mouse-mode t)


;; NOW NEEDED (EMACS >=24) TO ENABLE MOUSE MIDDLE BUTTON TO COPY/PASTE IN AND OUT
;;  OF EMACS
(setq select-active-regions nil)
(setq mouse-drag-copy-region t)
(global-set-key [mouse-2] 'mouse-yank-at-click)

;; CAN NOW PASTE TO /COPY FROM WINDOWS
(setq x-select-enable-clipboard t)

;; USES BUGGERY TO MAKE THINGS WORK LIKE THEY USED TO IN EMACS <=23
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
(require 'autopair)

(show-paren-mode t)
(setq-default show-paren-delay 0)
(setq-default scroll-step 1)

;;Typing 'yes' or 'no' in prompts is tiring. Instead use 'y'/'n' keys at prompts:
(defalias 'yes-or-no-p 'y-or-n-p)

;; Turn down the time to echo keystrokes so I don't have to wait around for things to happen
(setq echo-keystrokes 0.1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Similarly, to only use spaces for indentation everywhere:
;(setq-default indent-tabs-mode nil)
;(setq tab-width 4)

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
       inhibit-splash-screen t)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
(global-set-key (kbd "C-x C-r") 'query-replace-regexp)
;;(global-set-key [f4] 'goto-line)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [f1] "\C-x0")
(global-set-key [f2] "\C-x2")
(global-set-key [f3] "\C-x3")
;;(global-set-key [f3] "\C-x3")
;;(global-set-key [f4] 'describe-key)
;;(global-set-key [f5] 'eval-buffer)
;;(global-set-key (kbd "<f8>")  #'whitespace-mode)
;;(global-set-key "\C-xs" 'shell)
;;;(global-unset-key [insert]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
(defun display-startup-echo-area-message ()
  (message ".emacs loaded successfully."))
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
  (cd "C:/Praxeum/Dropbox/")
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
;;  (cd "/home/edward/Dropbox/")
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;(load-theme 'zenburn t)
;;;;(load-theme 'ample-zen t)
;;;;(load-theme 'zen-and-art t)
;;;;(load-theme 'adwaita t)
;;;;(load-theme 'deeper-blue t)
;;;;(load-theme 'dichromacy t)
;;;;(load-theme 'leuven t)
;;;;(load-theme 'light-blue t)
;;;;(load-theme 'manoj-dark t)
;;;;(load-theme 'misterioso t)
;;;;(load-theme 'wheatgrass t)
;;;;(load-theme 'whiteboard t)
;;(load-theme 'wombat t)
;(load-theme 'hc-zenburn t)
;(load-theme 'tsdh-dark t)
(load-theme 'tango-dark t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CLEAN UP WHITE SPACES FROM COPY/PASTE ETC
(add-hook 'before-save-hook 'whitespace-cleanup)

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

;; (defun my-backup-file-name (fpath)
;;     "Return a new file path of a given file path.
;;     If the new path's directories does not exist, create them."
;;     (let* (
;;	   (backupRootDir "~/.emacs.d/emacs-backup/")
;;	   (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, ⁖ “C:”
;;	   (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
;;	   )
;;       (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
;;       backupFilePath
;;     )
;; )
;; (setq make-backup-file-name-function 'my-backup-file-name)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indentation and buffer cleanup
;; This re-indents, untabifies, and cleans up whitespace. It is stolen directly from the emacs-starter-kit.
;; (defun untabify-buffer ()
;;  (interactive)
;;  (untabify (point-min) (point-max)))

;; (defun indent-buffer ()
;;  (interactive)
;;  (indent-region (point-min) (point-max)))

;; (defun cleanup-buffer ()
;;  "Perform a bunch of operations on the whitespace content of a buffer."
;;  (interactive)
;;  (indent-buffer)
;;  (untabify-buffer)
;;  (delete-trailing-whitespace))

;; (defun cleanup-region (beg end)
;;  (interactive)
;;  (indent-buffer)
;;  (untabify-buffer)
;;  (delete-trailing-whitespace))
;;  delete-trailing-lines to nil

;; (global-set-key (kbd "C-c b") 'cleanup-region)
;; (global-set-key (kbd "C-c b") 'cleanup-buffer)

;(setq-default show-trailing-whitespace t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun xah-clean-whitespace (p1 p2)
;;     "Delete trailing whitespace, and replace repeated blank lines into just 2.
;;      This function works on whole buffer or text selection.

;;      URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
;;      version 2015-02-06"
;;     (interactive
;;       (if (region-active-p)
;;         (list (region-beginning) (region-end))
;;       (list 1 (point-max))))
;;     (save-excursion
;;       (save-restriction
;;         (narrow-to-region p1 p2)
;;         (progn
;;           (goto-char (point-min))
;;           (while (search-forward-regexp "[ \t]+\n" nil "noerror")
;;             (replace-match "\n")))
;;         (progn
;;           (goto-char (point-min))
;;           (while (search-forward-regexp "\n\n\n+" nil "noerror")
;;                    (replace-match "\n\n"))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TABS / INDENTATION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Here is AaronL’s C-style, as an example. It has been commented for your convenience.
					;(setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation;
					;             c-indent-level 4         ; A TAB is equivilent to four spaces
					;             c-argdecl-indent 0       ; Do not indent argument decl's extra
					;             c-tab-always-indent t
					;             backward-delete-function nil) ; DO NOT expand tabs when deleting
					;(c-add-style "my-c-style" '((c-continued-statement-offset 4))) ; If a statement continues on the next line, indent the continuation by 4

					;(defun my-c-mode-hook ()
					; (c-set-style "my-c-style")
					; (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
					; (c-set-offset 'inline-open '+)
					; (c-set-offset 'block-open '+)
					; (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
					; (c-set-offset 'case-label '+))       ; indent case labels by c-indent-level, too
					;(add-hook 'c-mode-hook 'my-c-mode-hook)
					;(add-hook 'c++-mode-hook 'my-c-mode-hook)

;;Setting Tab to indent region if anything is selected
					;(defun tab-indents-region ()
					;  (local-set-key [(tab)] 'fledermaus-maybe-tab))
					;(add-hook 'c-mode-common-hook   'tab-indents-region)

;;fledermaus came up with this
					;(defun fledermaus-maybe-tab ()
					;  (interactive)
					;  (if (and transient-mark-mode mark-active)
					;      (indent-region (region-beginning) (region-end) nil)
					;    (c-indent-command)))




;;  ***************  NEEDED ?????  *************** ;;
;;  ***************  NEEDED ?????  *************** ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NO LONGER NEEDED FOR SOME REASON - MODELINE SPECS TAKE OVER??
;; Line numbers are good.  Getting column numbering as well is better
;; The mode-line is made more useful by showing the progress through the file
;; (column-number-mode t);; (setq  size-indication-mode t);; (size-indication-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Turn on auto complete.
;(require 'auto-complete-config)
;(ac-config-default)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Marking text
;; I like to see what's selected in the buffer.
;; This turns on visual feedback on selections.
;(transient-mark-mode t)
;; Emacs also has it's own clipboard and doesn't respond to the system clipboard
;; by default, so tell Emacs that we're all friends and can get along
;; Hence, enable emacs to copy to the clipboard
;(setq x-select-enable-clipboard t)
;;don't know when/if this will ne needed
;; interprogram-paste-function 'x-cut-buffer-or-selection-value
;;(setq x-cut-buffer-or-selection-value t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

