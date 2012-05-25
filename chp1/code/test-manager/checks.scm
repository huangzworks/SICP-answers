;;; ----------------------------------------------------------------------
;;; Copyright 2007-2009 Alexey Radul.
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

(cond-expand
 (guile
  (define-macro (check assertion)
    (if (list? assertion)
	(compute-check-form assertion "" #f)
	`(assert-true assertion))))
 (else
  (define-syntax check
    (sc-macro-transformer
     (lambda (form env)
       (let ((assertion (cadr form))
	     (message (if (null? (cddr form)) "" (caddr form))))
	 (if (list? assertion) 
	     (compute-check-form assertion message env)
	     `(assert-true ,(close-syntax assertion env)
			   ,(close-syntax message env)))))))))

(define (compute-check-form assertion message env)
  (define (wrap form)
    (close-syntax form env))
  (let loop ((bindings '())
	     (names '())
	     (assertion-left assertion))
    (if (null? assertion-left)
	`(let ,bindings
	   (assert-proc
	    (better-message
	     (list ,@(reverse names)) ',assertion ,(wrap message))
	    (lambda () ,(reverse names))))
	(let ((fresh-name (generate-uninterned-symbol)))
	  (loop (cons (list fresh-name (wrap (car assertion-left)))
		      bindings)
		(cons fresh-name names)
		(cdr assertion-left))))))

(define (better-message values quoted-form message)
  (build-message
   message
   '("Form      : " "\nArg values: " "\n")
   quoted-form
   (cdr values)))  ; cdr avoids the value of the operator

(define-syntax check-all
  (syntax-rules ()
    ((check-all form ...)
     (begin (check form) ...))))
