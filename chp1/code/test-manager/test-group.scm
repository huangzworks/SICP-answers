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

(define-record-type single-test
  (make-single-test name thunk docstring)
  single-test?
  (name st:name)
  (thunk st:thunk)
  (docstring st:docstring))

(define-record-type test-group
  (%make-test-group
   name
   group-surround group-set-up group-tear-down
   surround set-up tear-down
   test-map)
  test-group?
  (name tg:name)
  (group-surround tg:group-surround set-tg:group-surround!)
  (group-set-up tg:group-set-up set-tg:group-set-up!)
  (group-tear-down tg:group-tear-down set-tg:group-tear-down!)
  (surround tg:surround set-tg:surround!)
  (set-up tg:set-up set-tg:set-up!)
  (tear-down tg:tear-down set-tg:tear-down!)
  (test-map tg:test-map))

(define (make-test-group name)
  (%make-test-group 
   name
   (lambda (run-test) (run-test))
   (lambda () 'done)
   (lambda () 'done)
   (lambda (run-test) (run-test))
   (lambda () 'done)
   (lambda () 'done)
   (make-ordered-map)))

(define (tg:size group)
  (omap:count (tg:test-map group)))

(define (tg:register-test! group test)
  (omap:put! (tg:test-map group) (st:name test) test))

(define (tg:clear! group)
  (omap:clear! (tg:test-map group)))

(define (tg:find-or-make-subgroup group name)
  (let ((subgroup (omap:get (tg:test-map group) name #f)))
    (cond ((not subgroup)
	   (tg:make-subgroup! group name))
	  ((procedure? subgroup)
	   (error "Namespace collision between tests and subgroups" group name))
	  (else subgroup))))

(define (tg:make-subgroup! group name)
  (let ((new-group (make-test-group name)))
    (omap:put! (tg:test-map group) name new-group)
    new-group))

(define (tg:get group name)
  (cond ((null? name) group)
	((pair? name)
	 (tg:get (tg:get group (car name)) (cdr name)))
	(else
	 (omap:get (tg:test-map group) name #f))))

(define (tg:in-group-context group thunk)
  "Runs the given thunk in the whole-group context of the given test
group (see also tg:in-test-context)."
  ((tg:group-surround group)
   (lambda ()
     (dynamic-wind
	 (tg:group-set-up group)
	 thunk
	 (tg:group-tear-down group)))))

(define (tg:in-test-context group thunk)
  "Runs the given thunk in the single-test context of the given test
group.  Does not create the whole-group context provided by
tg:in-group-context."
  ((tg:surround group)
   (lambda ()
     (dynamic-wind
	 (tg:set-up group)
	 thunk
	 (tg:tear-down group)))))

(define *current-test-group* (make-test-group 'top-level))

(define (current-test-group) *current-test-group*)

(define (with-top-level-group group thunk)
  (fluid-let ((*current-test-group* group))
    (thunk)))

(define-syntax in-test-group
  (syntax-rules ()
    ((_ name body-exp ...)
     (let ((group (tg:find-or-make-subgroup *current-test-group* 'name)))
       (fluid-let ((*current-test-group* group))
	 body-exp ...)
       group))))

(define (*define-group-surround proc)
  (set-tg:group-surround! (current-test-group) proc))

(define (*define-group-set-up thunk)
  (set-tg:group-set-up! (current-test-group) thunk))

(define (*define-group-tear-down thunk)
  (set-tg:group-tear-down! (current-test-group) thunk))

(define (*define-surround proc)
  (set-tg:surround! (current-test-group) proc))

(define (*define-set-up thunk)
  (set-tg:set-up! (current-test-group) thunk))

(define (*define-tear-down thunk)
  (set-tg:tear-down! (current-test-group) thunk))

;;; Portable slightly non-hygienic macros suck...
(cond-expand
 (guile ;; TODO less hygienic than it should be...
  (define-macro (define-group-surround . body)
    `(*define-group-surround
      (lambda (run-test)
	,@body))))
 (else ;; The MIT Scheme that knows it is 'mit' isn't in Debian Stable yet
  (define-syntax define-group-surround
    (er-macro-transformer 
     (lambda (form rename compare)
       (let ((body (cdr form)))
	 `(,(rename '*define-group-surround)
	   (,(rename 'lambda) (run-test)
	    ,@body))))))))

(define-syntax define-group-set-up
  (syntax-rules ()
    ((_ body-exp ...)
     (*define-group-set-up
      (lambda ()
	body-exp ...)))))

(define-syntax define-group-tear-down
  (syntax-rules ()
    ((_ body-exp ...)
     (*define-group-tear-down
      (lambda ()
	body-exp ...)))))

;;; Portable slightly non-hygienic macros suck...
(cond-expand
 (guile ;; TODO less hygienic than it should be...
  (define-macro (define-surround . body)
    `(*define-surround
      (lambda (run-test)
	,@body))))
 (else ;; The MIT Scheme that knows it is 'mit' isn't in Debian Stable yet
  (define-syntax define-surround
    (er-macro-transformer 
     (lambda (form rename compare)
       (let ((body (cdr form)))
	 `(,(rename '*define-surround)
	   (,(rename 'lambda) (run-test)
	    ,@body))))))))

(define-syntax define-set-up
  (syntax-rules ()
    ((_ body-exp ...)
     (*define-set-up
      (lambda ()
	body-exp ...)))))

(define-syntax define-tear-down
  (syntax-rules ()
    ((_ body-exp ...)
     (*define-tear-down
      (lambda ()
	body-exp ...)))))
