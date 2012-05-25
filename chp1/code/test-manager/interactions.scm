;;; ----------------------------------------------------------------------
;;; Copyright 2009 Alexey Radul.
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

;;; This is an MIT-Scheme specific facility for faking out the repl
;;; history in tests.  For example:
;; (define-test (interactions)
;;   (interaction
;;    (define foo 5)
;;    (+ foo 2)
;;    (produces 7)))
;;; will actually verify that (+ foo 2) produces 7 (using the
;;; generic-match facility).  Furthermore, the entire body of the
;;; (interaction ...) form can be copied into a repl wholesale, and
;;; will retain the same effect.  This relies on fluid-rebinding
;;; the (out) procedure provided by MIT Scheme.

(cond-expand
 (guile
  (define-macro (interaction . subforms)
    (compute-interaction-form subforms)))
 (else
  (define-syntax interaction
    (sc-macro-transformer
     (lambda (form use-env)
       (compute-interaction-form (cdr form)))))))

(define (compute-interaction-form subforms)
  (let ((history-name (make-synthetic-identifier 'history)))
    `(let ((,history-name (make-interaction-history)))
       (fluid-let ((out (read-interaction ,history-name)))
	 ,@(map (attach-history-tracking history-name) subforms)
	 (cadr ,history-name)))))

(define (attach-history-tracking history-name)
  (lambda (subform)
    (if (apparent-definition? subform)
	subform
	`(record-interaction ,subform ,history-name))))

(define (apparent-definition? form)
  (and (pair? form)
       (symbol? (car form))
       (string-search-forward "define" (symbol->string (car form)))))

(define (make-interaction-history)
  (list '*interaction-history*))

(define (record-interaction thing history)
  (set-cdr! history (cons thing (cdr history))))

(define (read-interaction history)
  (lambda args
    (let-optional args ((index 1))
      (list-ref (cdr history) (- index 1)))))

(define (produces pattern)
  (check (generic-match pattern (out))))
