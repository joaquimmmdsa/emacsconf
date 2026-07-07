;; ==========================================
;; 1. CONFIGURACIÓ DE REPOSITORIS (MELPA)
;; ==========================================
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; ==========================================
;; 2. INTERFÍCIE, NÚMEROS I SCROLL SUAU
;; ==========================================
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq pixel-scroll-precision-mode t)

(setq native-comp-async-report-warnings-errors 'silent)
(setq warning-minimum-level :error)

(global-display-line-numbers-mode t)

;; ==========================================
;; 3. CONFIGURACIÓ DE LA FONT
;; ==========================================
(set-face-attribute 'default nil 
                    :font "JetBrains Mono" 
                    :height 110 
                    :weight 'regular)

(set-face-attribute 'fixed-pitch nil 
                    :font "JetBrains Mono" 
                    :height 110)

;; ==========================================
;; 4. TEMA VISUAL
;; ==========================================
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-medium t))

;; ==========================================
;; 5. DASHBOARD
;; ==========================================
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (bookmarks . 5)))
  (setq dashboard-banner-logo-title "Benvingut a Emacs!")
  (setq dashboard-startup-banner 'official)
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-footer "Bon camí, hacker!"))

;; ==========================================
;; 6. MINIBUFFER
;; ==========================================
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

;; ==========================================
;; 7. WHICH-KEY
;; ==========================================
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :custom
  (which-key-idle-delay 0.3))

;; ==========================================
;; 8. UNDO-TREE
;; ==========================================
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode)
  :custom
  (undo-tree-auto-save-history nil))

;; ==========================================
;; 9. ICONES I MODEL-LINE
;; ==========================================
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 30)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-encoding nil))

;; ==========================================
;; 10. TERMINAL
;; ==========================================
(use-package vterm
  :ensure t)

(global-set-key (kbd "M-<f1>") 'vterm)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))

;; ==========================================
;; 11. MARKDOWN
;; ==========================================
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :init 
  (setq markdown-command "pandoc"))

;; ==========================================
;; 12. AUTOCOMPLETAT
;; ==========================================
(use-package company
  :ensure t
  :init
  (global-company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; ==========================================
;; 13. PDF
;; ==========================================
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-view-midnight-colors '("#ebdbb2" . "#282828"))
  
  :hook (pdf-view-mode . (lambda ()
                           (display-line-numbers-mode -1)
                           (pdf-view-midnight-mode 1))))

;; ==========================================
;; 14. CSV (IMPORTANT 🔥)
;; ==========================================
(use-package csv-mode
  :ensure t
  :mode (("\\.csv\\'" . csv-mode)
         ("\\.tsv\\'" . tsv-mode))
  :hook (csv-mode . my-csv-setup)
  :config
  ;; suport per , ; i tab (Excel europeu inclòs)
  (setq csv-separators '("," ";" "\t"))

  (defun my-csv-setup ()
    (display-line-numbers-mode -1)
    (visual-line-mode -1)
    (toggle-truncate-lines 1)

    ;; alineació automàtica
    (csv-align-fields nil (point-min) (point-max))))

;; ==========================================
;; 15. CUSTOM
;; ==========================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9b9d7a851a8e26f294e778e02c8df25c8a3b15170e6f9fd6965ac5f2544ef2a9" default))
 '(package-selected-packages
   '(csv-mode undo-tree dashboard which-key marginalia vertico pdf-tools company-box company markdown-mode vterm all-the-icons-dired gruvbox-theme doom-modeline all-the-icons use-package)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ==========================================
;; 16. UTILS PERSONALS
;; ==========================================
(put 'dired-find-alternate-file 'disabled nil)

(defun obrir-ajuda ()
  (interactive)
  (find-file "~/ajuda.txt"))

(global-set-key (kbd "C-c h") 'obrir-ajuda)

(setq dashboard-set-footer "Why are you looking at me?")
