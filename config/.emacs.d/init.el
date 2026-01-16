;;; init.el --- Emacs configuration

;;; Commentary:
;; Minimal Emacs configuration

;;; Code:

;; -------------------------------------------------------------------------
;; Package management
;; -------------------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; -------------------------------------------------------------------------
;; C-h to backspace
;; -------------------------------------------------------------------------
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; Help command to C-?
(global-set-key (kbd "C-?") 'help-command)

;; -------------------------------------------------------------------------
;; Basic settings
;; -------------------------------------------------------------------------

;; No startup message
(setq inhibit-startup-message t)

;; No menu bar
(menu-bar-mode -1)

;; No backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Auto save visited files (Emacs 26.1+)
(auto-save-visited-mode t)
(setq auto-save-visited-interval 1) ; save every 1 second

;; UTF-8
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; Show column number
(column-number-mode t)

;; Highlight matching parentheses
(show-paren-mode t)

;; No tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Scroll one line at a time
(setq scroll-step 1)
(setq scroll-conservatively 10000)

;; -------------------------------------------------------------------------
;; Terminal specific
;; -------------------------------------------------------------------------

;; Enable mouse in terminal
(xterm-mouse-mode t)

;; -------------------------------------------------------------------------
;; Completion - vertico + orderless + consult (Ctrl-P like)
;; -------------------------------------------------------------------------

;; vertico - vertical completion UI
(use-package vertico
  :init
  (vertico-mode))

;; orderless - fuzzy matching
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; consult - enhanced commands (find-file, grep, etc.)
(use-package consult
  :bind
  (("C-x b" . consult-buffer)      ; switch buffer
   ("C-s" . consult-line)          ; search in buffer
   ("M-g g" . consult-goto-line)   ; goto line
   ("M-s r" . consult-ripgrep)))   ; ripgrep

;; project.el (built-in) - C-c p for project file finder
(setq project-vc-include-untracked t)
(global-set-key (kbd "C-c p") 'project-find-file)

;; C-c C-p for all files (including .gitignore)
(setq consult-fd-args '((if (executable-find "fdfind") "fdfind" "fd")
                        "--color=never"
                        "--hidden"
                        "--no-ignore"
                        "--exclude" ".git"))
(global-set-key (kbd "C-c C-p") 'consult-fd)

;; marginalia - annotations in minibuffer
(use-package marginalia
  :init
  (marginalia-mode))

;; -------------------------------------------------------------------------
;; LSP - eglot (built-in since Emacs 29)
;; -------------------------------------------------------------------------

(use-package eglot
  :ensure nil  ; built-in
  :hook
  ((go-mode . eglot-ensure)
   (go-ts-mode . eglot-ensure))
  :config
  ;; gopls settings
  (setq-default eglot-workspace-configuration
                '(:gopls (:staticcheck t
                          :usePlaceholders t))))

;; markdown-mode
(use-package markdown-mode
  :mode "\\.md\\'"
  :bind (:map markdown-mode-map
              ("C-c C-p" . consult-fd)))

;; go-mode
(use-package go-mode
  :mode "\\.go\\'"
  :hook
  (go-mode . (lambda ()
               (setq tab-width 4)
               (setq indent-tabs-mode t))))  ; Go uses tabs

;; -------------------------------------------------------------------------
;; which-key - keybinding hints
;; -------------------------------------------------------------------------

(use-package which-key
  :init
  (which-key-mode))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
