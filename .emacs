;; Red Hat Linux default .emacs initialization file  ; -*- mode: emacs-lisp -*-

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
(global-set-key [f1] 'goto-line)
(global-set-key [f2] 'speedbar)
(global-set-key "\C-xb" 'buffer-menu) 
(global-set-key [?\C-h] 'delete-backward-char)
(global-set-key [?\C-x ?h] 'help-command)                      
(setq x-alt-keysym 'meta)


;; turn on font-lock mode
(global-font-lock-mode t)
;; enable visual feedback on selections
(setq-default transient-mark-mode t)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions))

(add-to-list 'load-path "~/.emacs.d/site-lisp/")

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;Add Folding
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (load "folding" 'nomessage 'noerror)
   (folding-mode-add-find-file-hook)

(setq folding-default-keys-function
       'folding-bind-backward-compatible-keys)
           (if (load "folding" 'nomessage 'noerror)
               (folding-mode-add-find-file-hook))
  (defun folding-mode-find-file-hook ()
    "One of the hooks called whenever a `find-file' is successful."
    (and (assq 'folded-file (buffer-local-variables))
         folded-file
         (folding-mode 1)
         (kill-local-variable 'folded-file)))

  (or (memq 'folding-mode-find-file-hook find-file-hooks)
      (setq find-file-hooks (append find-file-hooks
                                    '(folding-mode-find-file-hook))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq load-path (cons"/home/krekel/elisp/auctex/share/emacs/site-lisp" load-path))
;;(setq load-path (cons "/home/landry/elisp/auctex" load-path))
;;     (require 'tex-site)

;;

(setq default-frame-alist      '(
				 (top . 20) (left . 485)
				 (width . 80) (height . 50)	
				 (cursor-color . "red")
				 (background-color . "black")
				 (foreground-color . "green")
				 (vertical-scroll-bars . right)
				 )
      )
;; -----------------------------------------------------------------
;; Some display settings
 
(setq display-time-24hr-format t)		 ; In 24 hour format
(display-time) 					 ; Display the time
(setq-default auto-fill-function 'do-auto-fill)  ; Autofill in all modes   
(setq fill-column 78)                            ; wordwrap i this column



;; -----------------------------------------------------------------
;; Reftex activation (Reftex is included with Emacs 21.1)

(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;; ;; ;; -----------------------------------------------------------------
;; ;; ;; AUC TeX -- extra goodies
;; ;; ;; Extra commands for the Command-menu
;; ;; ;; Halfsize can be called after File. From a postscript file foo.ps,
;; ;; ;; it produces the file foo.2.ps with 2 pages per sheet.11        ("\\.cc\\'" . c++-mode)
;; ;; ;; psnup comes with miktex
(setq TeX-auto-save t) 
(setq TeX-parse-self t) 
(setq-default TeX-master nil); Query for Master file

(add-hook 'LaTeX-mode-hook
	  (function (lambda ()
		      (require 'reftex)
		      (turn-on-reftex)
		      (setq reftex-plug-into-AUCTeX t)
		      ;;(outline-minor-mode)
		      (add-to-list 'TeX-expand-list '("%g" file "pdf" t))
		      ;;(add-to-list 'TeX-command-list '("PDFTeX" "pdftex '\\nonstopmode\\input %t'" TeX-run-TeX nil t))
		      ;;(add-to-list 'TeX-command-list '("PDFTeX Interactive" "pdftex %t" TeX-run-interactive nil t))
		      ;;(add-to-list 'TeX-command-list '("PDFLaTeX" "pdflatex '\\nonstopmode\\input{%t}'" TeX-run-LaTeX nil t))
		      ;;(add-to-list 'TeX-command-list '("PDFLaTeX Interactive" "pdflatex %t" TeX-run-interactive nil t))
		      ;;(add-to-list 'TeX-command-list '("PDFView" "open -a /Applications/Office/TeXShop.app %g" TeX-run-command t nil))
		      (add-to-list 'TeX-command-list '("ThumbPDF" "thumbpdf %s" TeX-run-command nil nil))
		      ;;(add-to-list 'TeX-command-list '("AmSTeX" "amstex '\\nonstopmode\\input %t'" TeX-run-TeX nil t))
		      (add-to-list 'TeX-command-list (list "dviPDF" "dvipdfm %d" 'TeX-run-command nil t))
		      (add-to-list 'TeX-command-list (list "AcrobatPDF" "acroread %s.pdf" 'TeX-run-silent nil t))
		      ;;(setq TeX-command-default "PDFLaTeX")
		      ;; (setq TeX-command-next "PDFView")
		      (turn-on-auto-fill)
		      (setq ispell-parser 'tex)
		      ;;(flyspell-mode)
		      )))


;; ;; Math Mode

(setq LaTeX-math-mode t)
;; ;; Nice buffer stuff



;; ;; Some shortcuts bound to F11 and F12
;; (global-set-key [f11]      'TeX-next-error) ; goto next found
;; 					    ; LaTeX error
;; (global-set-key [f12]      'next-error)     ; goto next found lacheck
;; 					    ; error (run Check first)


;; ;; If you want '\' to be bound to the function TeX-electric-macro. This
;; ;; makes AucTeX prompt and make completion for the commands.
;; ;;(define-key TeX-mode-map "\\" 'TeX-electric-macro)

;; ;; This will enable a danish dictionary as default
;; ;(add-hook 'TeX-language-dk-hook
;; ;	  (function (lambda () (ispell-change-dictionary "dansk"))))

;;  Make AUC TeX aware of style files and multi-file documents

;; -----------------------------------------------------------------
;; Color highlighting in all modes
;; font-latex is provided with AUCTeX

;; here_n
;; (cond 
;;  (window-system
;;   (global-font-lock-mode t nil)
;;   (require 'font-latex)))

;; -----------------------------------------------------------------
;; Parentheses matching 
(show-paren-mode 1)

;; -----------------------------------------------------------------
;; ;;settings for bib-cite.el (provided with auctex)

;; (require 'imenu)
;; (define-key global-map [S-mouse-3] 'imenu)
;; (autoload 'turn-on-bib-cite "bib-cite")
;; (add-hook 'LaTeX-mode-hook 'turn-on-bib-cite)
;; (setq reftex-bibpath-environment-variables nil)

;; -----------------------------------------------------------------
;;settings for AUC tex


(add-hook 'TeX-style-hook-list 
 "graphicx"
 (function (lambda () 
	     (TeX-add-symbols
	      "protect" "clip" "keepaspectratio" "width" "height" "bb" "angle" "totalheight"

	      '("some" "yeah")))))

;; (add-hook 'texinfo-mode-hook
;; 	  '(lambda ()
;; 	     (define-key texinfo-mode-map "\C-cp"
;; 	       'backward-paragraph)
;; 	     (define-key texinfo-mode-map "\C-cn"
;; 	       'forward-paragraph)))

;; -----------------------------------------------------------------
;;settings for reftex



(setq reftex-extra-bindings t)

(add-hook 'reftex-mode-hook
               '(lambda ()
                  (define-key reftex-mode-map "\C-ct"
                              'reftex-toc)
                  (define-key reftex-mode-map "\C-cl"
                              'reftex-label)
		  (define-key reftex-mode-map "\C-cr"
                              'reftex-reference)
		  (define-key reftex-mode-map "\C-cc"
                              'reftex-citation)
		  (define-key reftex-mode-map "\C-cv"
                              'reftex-view-crossref)
		  (define-key reftex-mode-map "\C-cs"
                              'reftex-search-document)
		  (define-key reftex-mode-map "\C-cg"
                              'reftex-grep-document)

))
;;(reftex-mode-map [C-c t] 'reftex-toc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Answer y instead of yes on prompts.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
(defalias 'yes-or-no-p 'y-or-n-p)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Makes URL's clickable
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key [down-mouse-3] 'browse-url-at-mouse)




  (autoload 'octave-mode "octave-mod" nil t)
  (setq auto-mode-alist
        (cons '("\\.m$" . octave-mode) auto-mode-alist))



  (add-hook 'octave-mode-hook
	    (lambda ()
	      (abbrev-mode 1)
	      (auto-fill-mode 1)
	      (if (eq window-system 'x)
		  (font-lock-mode 1))))



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Fortran
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key [down-mouse-3] 'browse-url-at-mouse)


(add-hook 'fortran-mode-hook 'fortran-auto-fill-mode nil)   

;(global-set-key "\C-m" 'newline-and-indent) ;; a.1 
;(global-set-key "\C-j" 'newline) ;; a.2 
(setq fortran-mode-hook '(lambda() (abbrev-mode 1) ;; a.3 
(setq comment-start "! ") ;; a.4 
)) 

;part b (setq auto-mode-alist (append '(("\\.cs$" . fortran-mode) ("\\.cmn$" . fortran-mode) ("\\.for$" . fortran-mode)) auto-mode-alist))

;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
;;   ;; Your init file should contain only one such instance.
;;  '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "^landscape$") "%(o?)kdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "%(o?)kdvi %dS -paper a4 %d") ("^dvi$" ("^a5\\(?:comb\\|paper\\)$" "^landscape$") "%(o?)kdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^a5\\(?:comb\\|paper\\)$" "%(o?)kdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)kdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)kdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)kdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)kdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)kdvi %dS %d") ("^pdf$" "." "xpdf %o") ("^html?$" "." "netscape %o"))))
;;  '(TeX-view-style (quote (("^a4\\(?:dutch\\|paper\\|wide\\)?\\|sem-a4$" "%(o?)kdvi %dS -paper a4 %d") ("^a5\\(?:comb\\|paper\\)?$" "%(o?)kdvi %dS -paper a5 %d") ("^b5paper$" "%(o?)kdvi %dS -paper b5 %d") ("^letterpaper$" "%(o?)kdvi %dS -paper us %d") ("^legalpaper$" "%(o?)kdvi %dS -paper legal %d") ("^executivepaper$" "%(o?)kdvi %dS -paper 7.25x10.5in %d") ("^landscape$" "%(o?)kdvi %dS -paper a4r -s 0 %d") ("." "%(o?)kdvi %dS %d"))))
;;  '(ecb-options-version "2.24")
;;  '(load-home-init-file t t))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
;;   ;; Your init file should contain only one such instance.
;;  )


(setq auto-mode-alist
      '(("\\.bat\\'" . bat-generic-mode)
	("\\.m$" . octave-mode)
	("\\.tex$" . LaTeX-mode)
        ("\\.sty$" . LaTeX-mode)
        ("\\.bbl$" . LaTeX-mode)
        ("\\.bib$" . BibTeX-mode)
        ("\\.el\\'" . emacs-lisp-mode)
        ("\\.scm\\'" . scheme-mode)
        ("\\.l\\'" . lisp-mode)
        ("\\/data/Research/mc.lisp\\'" . lisp-mode)
        ("\\.f\\'" . fortran-mode)
        ("\\.F\\'" . fortran-mode)
        ("\\.par\\'" . fortran-mode)
        ("\\.PAR\\'" . fortran-mode)
        ("\\.for\\'" . fortran-mode)
	("\\.\\([pP][Llm]\\|al\\)\\'" . perl-mode)
        ("\\.cgi$"  . perl-mode)
        ("\\.s?html?\\'" . sgml-mode)
	("\\.ma?k\\'" . makefile-mode)
        ("\\(M\\|m\\|GNUm\\)akefile\\(\\.in\\)?" . makefile-mode)
        ("\\.am\\'" . makefile-mode)
        ("\\.mms\\'" . makefile-mode)
        ("\\.texinfo\\'" . texinfo-mode)
        ("\\.te?xi\\'" . texinfo-mode)
        ("\\.s\\'" . asm-mode)
        ("\\.S\\'" . asm-mode)
        ("\\.asm\\'" . asm-mode)
        ("ChangeLog\\'" . change-log-mode)
        ("change\\.log\\'" . change-log-mode)
        ("changelo\\'" . change-log-mode)
        ("ChangeLog\\.[0-9]+\\'" . change-log-mode)
        ("changelog\\'" . change-log-mode)
        ("changelog\\.[0-9]+\\'" . change-log-mode)
        ("\\$CHANGE_LOG\\$\\.TXT" . change-log-mode)
        ("\\.scm\\.[0-9]*\\'" . scheme-mode)
        ("\\.[ck]?sh\\'\\|\\.shar\\'\\|/\\.z?profile\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\(bash_profile\\|z?login\\|bash_login\\|z?logout\\)\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\(bash_logout\\|[kz]shrc\\|bashrc\\|t?cshrc\\|esrc\\)\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\([kz]shenv\\|xinitrc\\|startxrc\\|xsession\\)\\'" . sh-mode)
	("\\.sty\\'" . LaTeX-mode)
        ("\\.cls\\'" . LaTeX-mode)
        ("\\.clo\\'" . LaTeX-mode)
        ("\\.bbl\\'" . LaTeX-mode)
        ("\\.bib\\'" . BibTeX-mode)
	("\\.tcl\\'" . tcl-mode)
        ("\\.exp\\'" . tcl-mode)
        ("\\.itcl\\'" . tcl-mode)
        ("\\.itk\\'" . tcl-mode)
        ("\\.icn\\'" . icon-mode)
        ("\\.sim\\'" . simula-mode)
        ("\\.mss\\'" . scribe-mode)
        ("\\.f90\\'" . f90-mode)
        ("\\.F90\\'" . f90-mode)
	("\\.c\\'" . c-mode)
        ("\\.cc\\'" . c++-mode)
        ("\\.CC\\'" . c++-mode)
        ("\\.cpp\\'" . c++-mode)
        ("\\.py\\'" . python-mode)
	("\\.h\\'" . c-mode)
        ("\\.lsp\\'" . lisp-mode)
        ("\\.awk\\'" . awk-mode)
        ("\\.prolog\\'" . prolog-mode)
        ("\\.tar\\'" . tar-mode)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; compile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=

(global-set-key "\M-c" 'compile)


(if "~/.compile.emacs"
    (load "~/.compile.emacs" t t))




;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ;; cedet
;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; ;; Configuration variables here:
;; ;; (setq semantic-load-turn-useful-things-on t)
;; ;; ;; Load CEDET
;; ;; (load-file "/home/krekel/elisp/cedet-1.0beta2b/common/cedet.el")



;; ;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ;; ;; ecb
;; ;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; (add-to-list 'load-path
;; ;;                    "/home/krekel/elisp/ecb-2.24/")
;; ;; (require 'ecb)

;; ;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ;; ;; Hidden Text Mode
;; ;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defgroup hide-region nil
  "Functions to hide region using an overlay with the invisible
property. The text is not affected."
  :prefix "hide-region-"
  :group 'convenience)

(defcustom hide-region-before-string "@["
  "String to mark the beginning of an invisible region. This string is
not really placed in the text, it is just shown in the overlay"
  :type '(string)
  :group 'hide-region)

(defcustom hide-region-after-string "]@"
  "String to mark the beginning of an invisible region. This string is
not really placed in the text, it is just shown in the overlay"
  :type '(string)
  :group 'hide-region)

(defcustom hide-region-propertize-markers t
  "If non-nil, add text properties to the region markers."
  :type 'boolean
  :group 'hide-region)

(defvar hide-region-overlays nil
  "Variable to store the regions we put an overlay on.")

(defun hide-region-hide ()
  "Hides a region by making an invisible overlay over it and save the
overlay on the hide-region-overlays \"ring\""
  (interactive)
  (let ((new-overlay (make-overlay (mark) (point))))
    (setq hide-region-overlays
	  (append
	   (list new-overlay) hide-region-overlays))
    (overlay-put new-overlay 'invisible t)
    (overlay-put new-overlay 'intangible t)
    (overlay-put new-overlay 'before-string
                 (if hide-region-propertize-markers
                     (propertize hide-region-before-string
                                 'font-lock-face 'region)
                   hide-region-before-string))
    (overlay-put new-overlay 'after-string
                 (if hide-region-propertize-markers
                     (propertize hide-region-after-string
                                 'font-lock-face 'region)
                   hide-region-after-string))))

(defun hide-region-unhide ()
  "Unhide a region at a time, starting with the last one hidden and
deleting the overlay from the hide-region-overlays \"ring\"."
  (interactive)
  (if (car hide-region-overlays)
      (progn
	(delete-overlay (car hide-region-overlays))
	(setq hide-region-overlays (cdr hide-region-overlays)))))

(provide 'hide-region)

;;; hide-region.el ends here

(set-face-attribute 'default nil :height 140)

;;; cperl-mode is preferred to perl-mode    
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

;; LAMMPS auto-mode
;; translation of keyword classes from tools/vim
;; see http://xahlee.org/emacs/elisp_syntax_coloring.html

(load "~/.emacs.d/mylmp_emacs")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(delete-selection-mode nil)
 '(inhibit-startup-screen t)
 '(python-guess-indent t)
 '(scroll-bar-mode (quote right)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

