
(require 'intens-mode)
(require 'htmlize) ; export to markdown

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (java . t)))
;;  Org executes code blocks without prompting the user for confirmation
;;  and uses css
(setq org-confirm-babel-evaluate nil)
(setq org-html-htmlize-output-type 'css)
