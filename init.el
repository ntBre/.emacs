(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups"))
      auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save-list/" t)))

(use-package evil
  :ensure t
  :config
  (evil-mode t)
  (evil-set-undo-system 'undo-redo))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(add-hook 'compilation-mode-hook
	  (lambda ()
	    (evil-local-set-key 'motion (kbd "TAB") 'compilation-next-error)))

(use-package magit
  :ensure t)

(use-package company
  :ensure t
  :hook (emacs-lisp-mode . company-tng-mode)
  :config
  (setq company-idle-delay 0.5
	company-minimum-prefix-length 2))

(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package eglot
  :ensure t
  :demand t
  :bind (:map eglot-mode-map
	      ("<f6>" . eglot-format-buffer)
	      ("C-c a" . eglot-code-actions)
	      ("C-c d" . eldoc)
	      ("C-c r" . eglot-rename))
  :config
  (setq eglot-ignored-server-capabilities '(:inlayHintProvider)))

(use-package eldoc
  :ensure t
  :custom (eldoc-echo-area-use-multiline-p 'truncate-sym-name-if-fit))

(setq read-process-output-max (* 1024 1024))

(use-package rust-mode
  :ensure t)

(use-package rust-ts-mode
  :ensure t
  :after (eglot)
  :hook ((rust-ts-mode . eglot-ensure)
	 (rust-ts-mode . company-tng-mode)
	 (rust-ts-mode . (lambda ()
			   (eglot-inlay-hints-mode -1))))
  :config
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'eglot-server-programs '(rust-ts-mode . ("rust-analyzer"))))

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package rainbow-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(setq-default fill-column 80)
(add-hook 'prog-mode-hook
	  (defun brw/prog-mode-hook ()
	    (display-line-numbers-mode)
	    (display-fill-column-indicator-mode)))

(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "C-c i") 'imenu)
(global-set-key (kbd "C-M-.") 'xref-find-definitions-other-window)
 
(desktop-save-mode 1)

(load-theme 'tango-dark)

;;; fonts
(defun brw/big-font ()
  "Set a larger font for streaming"
  (interactive)
  (set-face-attribute 'default nil :height 140))

(defun brw/normal-font ()
  "Set a more usable font for not streaming"
  (interactive)
  (set-face-attribute 'default nil :height 110))

(brw/normal-font)

;; try to fix the unreadable completion colors
(set-face-attribute 'vertico-current nil :background "#d0d0FF")
(set-face-attribute 'completions-common-part nil :foreground "#0000FF")

;; disable all bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; improve scrolling behavior
(setq scroll-step 1
      scroll-conservatively 1)

;; pretend like I have winum
(global-set-key (kbd "M-1") 'other-window)
(global-set-key (kbd "M-2") 'other-window)

;; enable undoing window changes
(winner-mode t)
