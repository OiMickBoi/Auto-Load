;; The two most useful functions in Emacs when you're learning how to configure it are: 


;; * describe-variable (C-h v / Ctrl+H then V) - Shows documentation for any variable in Emacs
;; * describe-function (C-h f / Ctrl+H then F) - Shows documentation for any function in Emacs
;; * The best of both worlds: describe-symbol (C-h o / Ctrl+H then O)!

;; =========================================== SETUP =====================================================
;; Clean the Screen
(setq inhibit-startup-message t) ; Don't show the splash screen
(setq visible-bell t)            ; Flash when the bell rings

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode -1)
(menu-bar-mode -1)



;; WHEATGRASS THEME
(load-theme 'wheatgrass t)

;; Buffer config
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode 1)

; make ibuffer default
;(defalias 'list-buffers 'ibuffer) 

;; tabbar

;; (use-package tabbar
;; :ensure t
;; :config (tabbar-mode 1))
;; (global-set-key [M-left] 'tabbar-backward-tab)
;; (global-set-key [M-right] 'tabbar-forward-tab)

(require 'powerline)
(powerline-default-theme)

(setq tabbar-ruler-global-tabbar t)    ; get tabbar
;;(setq tabbar-ruler-global-ruler t)     ; get global ruler
;;(setq tabbar-ruler-popup-menu t)       ; get popup menu.
;;(setq tabbar-ruler-popup-toolbar t)    ; get popup toolbar
;;(setq tabbar-ruler-popup-scrollbar t)  ; show scroll-bar on mouse-move
(require 'tabbar-ruler)

;; window
(windmove-default-keybindings)
(winner-mode 1)


;; =========================================== PACKAGE MANAGER ===========================================

;;; PACKAGE LIST
(setq package-archives 
      '(("melpa" . "https://melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))


(require 'use-package)
(setq use-package-always-ensure t)

(use-package which-key
:ensure t
:config
(which-key-mode))

;; =========================================== LINE NUMBER ================================================
;; (global-display-line-numbers-mode)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; ;; Relative
;; (defvar my-linum-current-line-number 0) 

;; (setq linum-format 'my-linum-relative-line-numbers)

;; (defun my-linum-relative-line-numbers (line-number)
;;   (let ((test2 (- line-number my-linum-current-line-number)))
;;     (propertize
;;      (number-to-string (cond ((<= test2 0) (* -1 test2))
;;                              ((> test2 0) test2)))
;;      'face 'linum)))

;; (defadvice linum-update (around my-linum-update)
;;   (let ((my-linum-current-line-number (line-number-at-pos)))
;;     ad-do-it))
;; (ad-activate 'linum-update)

;; ;; (global-linum-mode t)

;; =========================================== EVIL MODE =============================================
;;; UNDO
;; Vim style undo not needed for emacs8
(use-package undo-fu)

;;; VIM BINDINGS
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 0))

;; org mode
;; (add-to-list 'load-path "/path/to/org-evil/directory")
;; (require 'org-evil)


;; =========================================== ORG MODE =================================================
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; =========================================== OTHER ====================================================
;; MPC MUSIC PLAYER
(setq
  mpc-browser-tags '(Artist Album)
  mpc-songs-format "%-5{Time} %25{Title} %20{Album} %20{Artist}")

;; IVY
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Latex
;; (load "auctex.el" nil t t)
;; (require 'tex-mik)
;;      (setq TeX-auto-save t)
;;     (setq TeX-parse-self t)
;;     (setq-default TeX-master nil)

;;     (add-hook 'LaTeX-mode-hook 'visual-line-mode)
;;     (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;;     (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;;     (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;     (setq reftex-plug-into-AUCTeX t)

;; add zip folders
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes 
                 '("\\.zip\\'" ".zip" "unzip")))

;; Download Audio with yt-dlp
(defun my-download-audio-from-url (url directory)
  "Download audio from URL using yt-dlp, optionally specifying DIRECTORY."
  (interactive
   (list
    (read-string "Enter URL: ")
    (read-directory-name "Download directory (default: ~/Music/): " "~/Music/" nil nil)))
  (let ((default-directory (if (string-empty-p directory) "~/Music/" directory))
        (command (format "yt-dlp -f bestaudio --audio-quality 0 --audio-format mp3 -i -x --extract-audio -o \"%%(playlist_index)02d - %%(title)s.%%(ext)s\" %s" url)))
    (async-shell-command command "*yt-dlp*")))

(global-set-key (kbd "C-c y") 'my-download-audio-from-url)


;; emms


 ;; Emacs Multimedia System
  (use-package emms
    :config
    (require 'emms-setup)
    (require 'emms-mpris)
    (emms-all)
    (emms-default-players)
    (emms-mpris-enable)
    :custom
    (emms-browser-covers #'emms-browser-cache-thumbnail-async)
    :bind
    (("C-c w m b" . emms-browser)
     ("C-c w m e" . emms)
     ("C-c w m p" . emms-play-playlist )
     ("<XF86AudioPrev>" . emms-previous)
     ("<XF86AudioNext>" . emms-next)
     ("<XF86AudioPlay>" . emms-pause)))




;; =========================================== AUTO-GENERATED ===========================================

;; AUTO-GENERATED
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#323334" "#C16069" "#A2BF8A" "#ECCC87" "#80A0C2" "#B58DAE" "#86C0D1" "#eceff4"])
 '(custom-enabled-themes '(doom-gruvbox))
 '(custom-safe-themes
   '("467dc6fdebcf92f4d3e2a2016145ba15841987c71fbe675dcfe34ac47ffb9195" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "016f665c0dd5f76f8404124482a0b13a573d17e92ff4eb36a66b409f4d1da410" "49acd691c89118c0768c4fb9a333af33e3d2dca48e6f79787478757071d64e68" "a589c43f8dd8761075a2d6b8d069fc985660e731ae26f6eddef7068fece8a414" "5586a5db9dadef93b6b6e72720205a4fa92fd60e4ccfd3a5fa389782eab2371b" "2853dd90f0d49439ebd582a8cbb82b9b3c2a02593483341b257f88add195ad76" "afa47084cb0beb684281f480aa84dab7c9170b084423c7f87ba755b15f6776ef" "51c71bb27bdab69b505d9bf71c99864051b37ac3de531d91fdad1598ad247138" "e1f4f0158cd5a01a9d96f1f7cdcca8d6724d7d33267623cc433fe1c196848554" "a138ec18a6b926ea9d66e61aac28f5ce99739cf38566876dc31e29ec8757f6e2" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "7e068da4ba88162324d9773ec066d93c447c76e9f4ae711ddd0c5d3863489c52" "c865644bfc16c7a43e847828139b74d1117a6077a845d16e71da38c8413a5aaa" "1cae4424345f7fe5225724301ef1a793e610ae5a4e23c023076dc334a9eb940a" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "2dd4951e967990396142ec54d376cced3f135810b2b69920e77103e0bcedfba9" "4ff1c4d05adad3de88da16bd2e857f8374f26f9063b2d77d38d14686e3868d8d" default))
 '(exwm-floating-border-color "#181818")
 '(fci-rule-color "#525252")
 '(highlight-tail-colors ((("#3d413c") . 0) (("#3a4143") . 20)))
 '(ispell-dictionary nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#000000" "#80A0C2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#000000" "#A2BF8A"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#000000" "#3f3f3f"))
 '(objed-cursor-color "#C16069")
 '(package-selected-packages
   '(try helm-lsp lsp-java lsp-ui company hydra lsp-mode yasnippet flycheck projectile org-pdfview pdf-tools emms modus-themes doom-themes all-the-icons helpful rainbow-delimiters command-log-mode doom-modeline ivy tabbar-ruler mode-icons powerline tabbar undo-fu evil use-package cmake-mode))
 '(pdf-view-midnight-colors (cons "#eceff4" "#323334"))
 '(rustic-ansi-faces
   ["#323334" "#C16069" "#A2BF8A" "#ECCC87" "#80A0C2" "#B58DAE" "#86C0D1" "#eceff4"])
 '(vc-annotate-background "#323334")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A2BF8A")
    (cons 40 "#bac389")
    (cons 60 "#d3c788")
    (cons 80 "#ECCC87")
    (cons 100 "#e3b57e")
    (cons 120 "#da9e75")
    (cons 140 "#D2876D")
    (cons 160 "#c88982")
    (cons 180 "#be8b98")
    (cons 200 "#B58DAE")
    (cons 220 "#b97e97")
    (cons 240 "#bd6f80")
    (cons 260 "#C16069")
    (cons 280 "#a0575e")
    (cons 300 "#804f54")
    (cons 320 "#5f4749")
    (cons 340 "#525252")
    (cons 360 "#525252")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
