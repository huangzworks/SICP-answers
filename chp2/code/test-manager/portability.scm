;;; ----------------------------------------------------------------------
;;; Copyright 2007-2008 Alexey Radul.
;;; ----------------------------------------------------------------------
;;; This file is part of Test Manager.
;;; 
;;; Test Manager is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;; 
;;; Test Manager is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Test Manager.  If not, see <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

;; Macros
(cond-expand
 (guile
  (use-modules (ice-9 syncase)))
 (else))

;; SRFI-9: define-record-type
(cond-expand
 (guile
  (use-modules (srfi srfi-9)))
 (srfi-9))

;; Structured conditions
(cond-expand
 (guile
  (load-relative "guile-conditions"))
 (else ;; The MIT Scheme that knows it is 'mit' isn't in Debian Stable yet
  (load-relative "mitscheme-conditions")))

;; SRFI-69: Hash tables
(cond-expand
 (srfi-69)
 (else ; Do I want to use Guile's hash tables instead?
  (load-relative "srfi-69-hash-tables")))

;; Optional arguments
(cond-expand
 (guile
  (use-modules (ice-9 optargs)))
 (else ;; The MIT Scheme that knows it is 'mit' isn't in Debian Stable yet
  (define-syntax let-optional
    (syntax-rules ()
      ((_ arg-list () expr ...)
       (begin expr ...))
      ((_ arg-list ((variable1 default1) binding ...) expr ...)
       (if (null? arg-list)
	   (let ((variable1 default1) binding ...)
	     expr ...)
	   (let ((variable1 (car arg-list))
		 (arg-list (cdr arg-list)))
	     (let-optional
	      arg-list
	      (binding ...)
	      expr ...))))
      ((_ arg-list (variable1 binding ...) expr ...)
       (let ((variable1 (car arg-list))
	     (arg-list (cdr arg-list)))
	 (let-optional
	  arg-list
	  (binding ...)
	  expr ...)))
      ))
  ))

;; Fluid-let (in the MIT Scheme sense of the word 'fluid'.
(cond-expand
 (guile
  (define-syntax fluid-let
    (syntax-rules ()
      ((_ () expr ...)
       (begin expr ...))
      ((_ ((variable1 value1) binding ...) expr ...)
       (let ((out-value variable1)
	     (in-value value1))
	 (dynamic-wind
	     (lambda ()
	       (set! out-value variable1)
	       (set! variable1 in-value))
	     (lambda ()
	       (fluid-let (binding ...)
		 expr ...))
	     (lambda ()
	       (set! in-value variable1)
	       (set! variable1 out-value))))))))
 (else))

;; Regexes (using MIT Scheme's name for no good reason)
(cond-expand
 (guile
  (use-modules (ice-9 regex))
  (define re-string-search-forward string-match))
 (else
  (load-option 'regular-expression)))

(cond-expand
 (guile
  (define (string-search-forward pattern string)
    (string-contains string pattern)))
 (else
  'ok))

;; Pretty printing
(cond-expand
 (guile
  ;; TODO Does Guile have pretty printing?
  (define (pp thing) (display thing) (newline)))
 (else))

;; Object system
(cond-expand
 (guile
  'ok)
 (else
  (load-option 'sos)))

;; Symbols
(cond-expand
 (guile
  (define (generate-uninterned-symbol)
    (make-symbol "symbol"))
  (define (make-synthetic-identifier prefix) 
    (make-symbol (symbol->string prefix))))
 (else
  'ok))

;; Hackery to make syntactic-closures macro code work (with less
;; hygiene!) in Guile's defmacro system.
(cond-expand
 (guile
  (define (close-syntax form env)
    form))
 (else
  'ok))

;; Faking out the repl history.  (produces foo) will not work at the
;; Guile repl.
(cond-expand
 (guile
  (define (out)
    #f))
 (else
  'ok))
