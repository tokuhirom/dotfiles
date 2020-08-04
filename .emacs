;; ------------------------------------------------------
;; package installer
;; ------------------------------------------------------

    (require 'package)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
    (package-initialize)

    ;   M-x package-refresh-contents
    ;   M-x package-install RET evil

;; ------------------------------------------------------
;; basic configuration
;; ------------------------------------------------------

;; Do not create back up files
(setq make-backup-files nil)


    ; hide tool-bar
    (tool-bar-mode -1)

    ; mac で日本語入力ちらつくのを治す
    ; http://hylom.net/emacs-25.1-ime-flicker-problem
    (setq redisplay-dont-pause nil)

					; color theme
    (load-theme 'solarized-dark t)
    (keyboard-translate ?\C-h ?\C-?)
;;次のウィンドウへ移動
(define-key global-map (kbd "C-x C-n") 'next-multiframe-window)
;;前のウィンドウへ移動
(define-key global-map (kbd "C-x C-p") 'previous-multiframe-window)

(define-key global-map (kbd "M-v") 'yank)
(define-key global-map (kbd "M-c") 'kill-ring-save)
(define-key global-map (kbd "M-z") 'undo)

;; Http://qiita.com/hayamiz/items/0f0b7a012ec730351678
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))

;; Disable "Symbolic link to Git-controlled source file; follow link? (y or n)"
;; https://stackoverflow.com/questions/15390178/emacs-and-symbolic-links
(setq vc-follow-symlinks t)


;; ------------------------------------------------------
;; helm
;; ------------------------------------------------------

;;    (require 'helm-config)
;;    (global-set-key (kbd "M-x") 'helm-M-x)
    ; (helm-mode 1)

;; ------------------------------------------------------
;; ivy(helm alternative)
;; ------------------------------------------------------

;; https://twitter.com/typester/status/1089932791150592001

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
; (global-set-key (kbd "<f1> l") 'counsel-find-library)
; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
; (global-set-key (kbd "C-c g") 'counsel-git)
; (global-set-key (kbd "C-c j") 'counsel-git-grep)
; (global-set-key (kbd "C-c k") 'counsel-ag)
; (global-set-key (kbd "C-x l") 'counsel-locate)
; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


;; ------------------------------------------------------
;; evil - vi layer for emacs
;; ------------------------------------------------------

    ;(require 'evil)
    ;(evil-mode 1)


;; ------------------------------------------------------
;; howm
;; ------------------------------------------------------
    ; C-, ,

;; 完了ずみ todo は表示しない
(setq howm-todo-menu-types "[-+~!]")


;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))


;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))

;; M-t で今日の日付で todo 入力。
(defun oreore-howm-insert-todo ()
  (interactive)
  (insert (format-time-string "[%Y-%m-%d]+ ")))
(define-key esc-map
  "t"
  'oreore-howm-insert-todo)

;; markdown-mode でメモる
(setq howm-template "# %title%cursor\n%date\n")

    ; markdown compat
    (setq howm-view-title-header "#")
    (setq howm-home-directory (expand-file-name "~/Documents/howm/"))
    (setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.md")

(require 'howm-mode)
(howm-menu)

;; ------------------------------------------------------
;; calfw - nice calendar view
;; ------------------------------------------------------

; (require 'calfw)

(server-start) ;; for emacsclient

;; ------------------------------------------------------
;; auto-save-buffers-enhanced
;; ------------------------------------------------------

    (require 'auto-save-buffers-enhanced)
    (auto-save-buffers-enhanced t)

;; ------------------------------------------------------
;; mozc
;; https://qiita.com/Maizu/items/fee34328f559c7dc59d8
;; Note : C-\ to enable mozc.
;; ------------------------------------------------------

(require 'mozc)                                 ; mozcの読み込み
(set-language-environment "Japanese")           ; 言語環境を"japanese"に
(setq default-input-method "japanese-mozc")     ; IMEをjapanes-mozcに
(prefer-coding-system 'utf-8)                   ; デフォルトの文字コードをUTF-8に



;; ------------------------------------------------------
;; ------------------------------------------------------



(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (mozc ivy solarized-theme auto-save-buffers-enhanced howm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
