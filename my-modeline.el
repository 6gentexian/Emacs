;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ~/.emacs.d/lisp/my-modeline.el
;;
;;
;; Based off the brilliant script:
;; http://amitp.blogspot.sg/2011/08/emacs-custom-mode-line.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default
 mode-line-format
 '(; Position, including warning for 80 columns
   (:propertize "%4l:" face mode-line-position-face)
   (:eval (propertize "%3c" 'face
    (if (>= (current-column) 81)
    'mode-line-80col-face
    'mode-line-position-face)))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    "    ["
    (:eval (setq str my-mode-line-buffer-line-count))
    "]    "
   (-3 . "%p")
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   mode-line-client
   "  "
   ;; read-only or modified status
   (:eval
    (cond (buffer-read-only
       (propertize " RO " 'face 'mode-line-read-only-face))
      ((buffer-modified-p)
       (propertize " ** " 'face 'mode-line-modified-face))
      (t "     ")))
   "   "
  ;; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 30))
        face mode-line-folder-face)
   (:propertize "%b"
        face mode-line-filename-face)

  ;; narrow [default -- keep?]
   " %n "
  ;; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   "  %["
   (:propertize mode-name
        face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
              'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
        face mode-line-process-face)
   (global-mode-string global-mode-string)
   "    "
  ;; nyan-mode uses nyan cat as an alternative to %p
   (:eval (when nyan-mode (list (nyan-create))))
))

;; Helper functions
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
    (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output)
)
(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)

(defun my-mode-line-count-lines ()
  (setq my-mode-line-buffer-line-count
    (int-to-string
     (count-lines (point-min) (point-max)))))


;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)


(set-face-attribute 'mode-line nil   ;; main modeline bar and text colors
            :foreground "gray70" :background "gray20"
            :inverse-video nil
            :box '(:line-width 6 :color "gray20" :style nil))
(set-face-attribute 'mode-line-inactive nil
            :foreground "gray80" :background "gray40"
            :inverse-video nil
            :box '(:line-width 6 :color "gray40" :style nil))
(set-face-attribute 'mode-line-read-only-face nil
            :inherit 'mode-line-face
            :foreground "#4271ae" ;; blue
            :box '(:line-width 2 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil  ;; file modified warning
            :inherit 'mode-line-face
            :foreground "#c82829" ;; red
            :background "#ffffff" ;; white
            :box '(:line-width 2 :color "#c82829"))
(set-face-attribute 'mode-line-folder-face nil  ;; folder name text
            :inherit 'mode-line-face
            :foreground "gray60")
(set-face-attribute 'mode-line-filename-face nil  ;; file name text
            :inherit 'mode-line-face
            :foreground "yellow"  ;;"#eab700" ;; yellow
            :weight 'bold)
(set-face-attribute 'mode-line-position-face nil
            :inherit 'mode-line-face
            :family "Menlo" :height 100)
(set-face-attribute 'mode-line-mode-face nil  ;; mode text
            :inherit 'mode-line-face
            :foreground "DodgerBlue1") ;;"gray80")
(set-face-attribute 'mode-line-minor-mode-face nil
            :inherit 'mode-line-mode-face
            :foreground "gray40"
            :height 110)

(set-face-attribute 'mode-line-process-face nil
            :inherit 'mode-line-face
            :foreground "#eeeeec") ;; light light gray

(set-face-attribute 'mode-line-80col-face nil  ;; column 80 warning
            :inherit 'mode-line-position-face
            :foreground "black" :background "yellow")  ;;"#eab700")

(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'my-modeline)
