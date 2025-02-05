;;; init.el --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs


;; Stuff copied from various sources
;; e.g. http://www.emacs-bootstrap.com/ (!)

;;; Code:

(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; start maximized

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories.")

;; https://krsoninikhil.github.io/2018/12/15/easy-moving-from-vscode-to-emacs/

;;; Commentary:
;;

(require 'package)
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("GNU ELPA"     . 10)
        ("MELPA Stable" . 5)
        ("MELPA"        . 0)))
(package-initialize)

;; https://sam217pa.github.io/2016/09/02/how-to-build-your-own-spacemacs/#use-package
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)  ; unless it is already installed
  (package-refresh-contents)                ; updage packages archive
  (package-install 'use-package))           ; and install the most recent version of use-package
(require 'use-package)
(setq use-package-always-ensure t) ;; Always download if not available

;;(use-package dracula-theme
;;  :config
;;  (load-theme 'dracula t))

(use-package cyberpunk-theme
  :config
  (load-theme 'cyberpunk t))

(defun rvdb-toggle-menu-and-toolbar ()
  "Toggle both the tool bar and the menu."
  (interactive)
  (if menu-bar-mode
    (progn
	(menu-bar-mode -1)
	(tool-bar-mode -1))
    (progn
	(menu-bar-mode 1)
	(tool-bar-mode 1))
  )
)

(setq menu-bar-mode -1)

(defun rvdb-show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
)

;; source: https://stackoverflow.com/questions/9597391/emacs-move-point-to-last-non-whitespace-character
(defun rvdb-move-end-of-line-before-whitespace ()
  "Move to the last non-whitespace character in the current line."
  (interactive)
  (move-end-of-line nil)
  (re-search-backward "^\\|[^[:space:]]")
  (forward-char))

;; source https://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs
(defun rvdb-duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (forward-line arg))

;; source https://stackoverflow.com/questions/992685/auto-formatting-a-source-file-in-emacs
(defun rvdb-indent-buffer ()
  "indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; inspired by: https://github.com/ecxr/handmadehero/blob/master/misc/.emacs
(defconst rvdb-c-style
  '((c-basic-offset              . 4)
    (c-electric-pound-behavior   . (alignleft))
    (c-tab-always-indent         . t)
    (c-comment-only-line-offset  . 0)
    (c-hanging-braces-alist      . ((class-open)
                                    (class-close)
                                    (defun-open after)
                                    (defun-close)
                                    (inline-open)
                                    (inline-close)
                                    (brace-list-open)
                                    (brace-list-close)
                                    (brace-list-intro)
                                    (brace-list-entry)
                                    (block-open after)
                                    (block-close . c-snug-do-while)
                                    (substatement-open after)
                                    (statement-case-open)
                                    (class-open)))
    (c-hanging-colons-alist      . ((inher-intro)
                                    (case-label)
                                    (label)
                                    (access-label)
                                    (access-key)
                                    (member-init-intro)))
    (c-cleanup-list              . (scope-operator
                                    list-close-comma
                                    defun-close-semi))
    (c-offsets-alist             . ((arglist-close         .  c-lineup-arglist)
                                    (label                 . -4)
                                    (access-label          . -4)
                                    (substatement-open     .  0)
                                    (statement-case-intro  .  4)
                                    (statement-block-intro .  4)
                                    (case-label            .  4)
                                    (block-open            .  0)
                                    (inline-open           .  0)
                                    (topmost-intro-cont    .  0)
                                    (knr-argdecl-intro     . -4)
                                    (brace-list-open       .  0)
                                    (brace-list-intro      .  4)))
    (c-echo-syntactic-information-p . t))
    "Remco's C Style.")

(defun rvdb-c-hook ()
  "Set my style for the current buffer."
  (c-add-style "RvdB" rvdb-c-style t)

  ; 4-space tabs
  (setq tab-width 4
        indent-tabs-mode nil)
  (setq c-hanging-semi&comma-criteria '((lambda () 'stop))) ;; no auto-newline after ;
  (c-toggle-auto-newline 1)
  (message "RvdB C-style")
)
(add-hook 'c-mode-common-hook 'rvdb-c-hook)

;; bind keys
(cua-mode t)
(global-set-key (kbd "C-<right>") 'forward-word)
(global-set-key (kbd "C-<left>")  'backward-word)
(global-set-key (kbd "C-<down>")  'forward-paragraph)
(global-set-key (kbd "C-<up>")    'backward-paragraph)
(global-set-key (kbd "M-<left>")  'back-to-indentation) ;; first non-whitesp char
(global-set-key (kbd "M-<right>") 'rvdb-move-end-of-line-before-whitespace) ;; last non-whitesp char
(global-set-key (kbd "M-<up>")    'cua-scroll-down)
(global-set-key (kbd "M-<down>")  'cua-scroll-up)

(global-set-key (kbd "C-d")       'rvdb-duplicate-line)

(global-set-key (kbd "M-w")       'other-window)
(global-set-key (kbd "M-/")       'split-window-right)
(global-set-key (kbd "M-=")       'split-window-below)
(global-set-key (kbd "M-k")       'delete-window)
(global-set-key (kbd "M-b")       'switch-to-buffer)

(global-set-key (kbd "M-n")       'display-line-numbers-mode)
(global-set-key (kbd "M-f")       'counsel-find-file) ;; TODO: conditional on counsel
(global-set-key (kbd "M-s")       'save-buffer) ;; C-s is already search
(global-set-key (kbd "C-c f")     'rvdb-show-file-name)

(global-set-key (kbd "<f12>")     'rvdb-toggle-menu-and-toolbar)

(use-package delight)
(delight 'abbrev-mode " Abv" 'abbrev)

(use-package ivy-hydra) ;; annoyingly, I need this to avoid compile errors in ivy
(use-package ivy
  :delight
  :init (ivy-mode 1) ; globally at startup
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 20)
  (setq ivy-count-format "%d/%d "))

(use-package counsel
  :bind* ; load when pressed
  (("M-x"     . counsel-M-x)
   ("C-s"     . swiper)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-r" . counsel-recentf)  ; search for recently edited
   ("C-c g"   . counsel-git)      ; search for files in git repo
   ("C-c j"   . counsel-git-grep) ; search for regexp in git repo
   ("C-c /"   . counsel-ag)       ; Use ag for regexp
   ("C-x l"   . counsel-locate)
   ("C-x C-f" . counsel-find-file)
   ("<f1> f"  . counsel-describe-function)
   ("<f1> v"  . counsel-describe-variable)
   ("<f1> l"  . counsel-find-library)
   ("<f2> i"  . counsel-info-lookup-symbol)
   ("<f2> u"  . counsel-unicode-char)
   ("C-c C-r" . ivy-resume)))     ; Resume last Ivy-based completion

(use-package flycheck
  :init (global-flycheck-mode))

(use-package company
  :delight " comp"
  :config
  (setq company-idle-delay 0
	company-minimum-prefix-length 3)
  ;;(add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'emacs-lisp-mode-hook 'company-mode)
)

(use-package company-irony
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

(use-package irony
  :delight " irn"
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; company-c-headers
(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers))

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir))
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-prefix " Prj")

  (projectile-register-project-type 'make '("Makefile")
                                  :compile "make"
                                  :test "make test"
                                  :run "make run")

  (projectile-mode))
;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(use-package which-key
  :delight which-key-mode
  :init
  (which-key-mode)
  :config
  (which-key-setup-side-window-right-bottom)
  (setq which-key-sort-order 'which-key-key-order-alpha
    which-key-side-window-max-width 0.33
    which-key-idle-delay 0.5))


;; some settings I like
(setq inhibit-startup-screen t) ;; also because otherwise the intial workdir is ~
;; (cd "~/Coding/")

;; source: https://emacs.stackexchange.com/questions/5289/any-way-to-get-a-working-separator-line-between-fringe-line-numbers-and-the-buff
(set-face-attribute 'line-number nil :background "gray6" :foreground "gray42")
(set-face-attribute 'line-number-current-line nil :foreground "DarkOliveGreen1" :weight 'bold)
(set-cursor-color "DarkOliveGreen1")

;; highlight TODO
;; https://github.com/ecxr/handmadehero/blob/master/misc/.emacs
;; https://stackoverflow.com/questions/8551320/highlighting-todos-in-all-programming-modes
; Bright-red TODOs
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-note-face)
(mapc (lambda (mode)
	 (font-lock-add-keywords
	  mode
	  '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
            ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
	'(c++-mode c-mode emacs-lisp-mode))
(modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "Dark Green" nil nil t nil t nil nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; remove trail space before save
(setq show-trailing-whitespace t)

(setq make-backup-files nil) ;; stop creating backup~ files
(setq auto-save-default nil) ;; stop creating #autosave# files
(setq coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8)
(menu-bar-mode -1)
(tool-bar-mode -1)
;; rvdb-toggle-menu-and-toolbar toggles both
(show-paren-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; trying packages: ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package expand-region
  :bind
  ("C-=" .  er/expand-region)
  ("C-+" .  er/contract-region)) ;; Ctrl-Shift-=

(use-package buffer-move
  :bind (("C-c b <left>"  . buf-move-left)
         ("C-c b <right>" . buf-move-right)
         ("C-c b <up>"    . buf-move-up)
         ("C-c b <down>"  . buf-move-down)))

(use-package smooth-scrolling
  :config
  (setq smooth-scroll-margin 3)
  (smooth-scrolling-mode 1))

(use-package ag)

(use-package glsl-mode
  :commands glsl-mode)

(provide 'init)

;;; init.el ends here
