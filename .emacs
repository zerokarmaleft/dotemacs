;; ============================================================================
;; package.el / marmalade
;; ============================================================================

(add-to-list 'load-path "~/.emacs.d/")

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; ============================================================================
;; Temporary file location
;; ============================================================================
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; ============================================================================
;; Color theme
;; ============================================================================
(require 'color-theme-zenburn)
(color-theme-zenburn)

;; ============================================================================
;; Custom keybindings
;; ============================================================================
(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-}") 'paredit-forward-barf-sexp)
     (define-key paredit-mode-map (kbd "M-{") 'paredit-backward-barf-sexp)))

(require 'paredit)

;; ============================================================================
;; Git/GitHub
;; ============================================================================
(add-to-list 'load-path "~/.emacs.d/vendor/gist.el")
(require 'gist)

;; ============================================================================
;; C/C++/Objective C/Java/C#
;; ============================================================================
(setq
  c-default-style "linux"
  c-basic-offset  4)

;; ============================================================================
;; elisp
;; ============================================================================
(defun setup-elisp ()
  (font-lock-add-keywords nil '(("(\\|)" . 'paren-face)))
  (rainbow-delimiters-mode)
  (paredit-mode)
  (hl-sexp-mode))

(add-hook 'emacs-lisp-mode-hook 'setup-elisp)

;; ============================================================================
;; PLT Racket
;; ============================================================================
(load-file "~/Projects/geiser/elisp/geiser.el")

(defun setup-racket ()
  (rainbow-delimiters-mode)
  (paredit-mode)
  (hl-sexp-mode))

(add-hook 'emacs-lisp-mode-hook 'setup-racket)
(add-hook 'inferior-scheme-mode-hook 'setup-racket)

;; ============================================================================
;; Common Lisp
;; ============================================================================

;;(require 'slime)
;;(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;;(setq inferior-lisp-program "clisp")

;; ============================================================================
;; Clojure
;; ============================================================================
(require 'clojure-mode)

(defun setup-clojure ()
  (clojure-mode-font-lock-setup)
  (rainbow-delimiters-mode)
  (paredit-mode)
  (hl-sexp-mode)
  (define-key clojure-mode-map "{" 'paredit-open-brace)
  (define-key clojure-mode-map "}" 'paredit-close-brace))

(add-hook 'clojure-mode-hook 'setup-clojure)
(add-hook 'slime-repl-mode-hook 'setup-clojure)

;; ============================================================================
;; CoffeeScript
;; ============================================================================
(require 'coffee-mode)

(defun setup-coffee ()
  (set (make-local-variable 'tab-width) 2)
  (setq coffee-args-compile '("-c" "--bare"))
  (setq coffee-command "/usr/local/bin/coffee"))

(add-hook 'coffee-mode-hook 'setup-coffee)

;; ============================================================================
;; JavaScript
;; ============================================================================
(require 'js2-mode)

;; ============================================================================
;; HTML
;; ============================================================================
(load-file "~/Projects/nxhtml/autostart.el")

(setq
  nxhtml-global-minor-mode      t
  mumamo-chunk-coloring         'no-chunks-colored
  nxhtml-skip-welcome           t
  indent-region-mode            t
  rng-nxml-auto-validate-flag   nil
  nxml-degraded                 t)

(defun setup-html ()
  (whitespace-mode)
  (setq truncate-lines 0))

(add-hook 'html-mode-hook 'setup-html)

;; ============================================================================
;; yasnippet
;; ============================================================================
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.6.1")

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/elpa/yasnippet-0.6.1/snippets")
