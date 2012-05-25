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

;;;; Test Registration

(define (register-test test)
  (tg:register-test! *current-test-group* test))

(define *anonymous-test-count* 0)

(define (generate-test-name)
  (set! *anonymous-test-count* (+ *anonymous-test-count* 1))
  (string->symbol
   (string-append "anonymous-test-" (number->string *anonymous-test-count*))))

(define (detect-docstring structure)
  (if (string? structure)
      structure
      #f))

;; TODO Teach Emacs to syntax-highlight this just like define
(define-syntax define-test
  (syntax-rules ()
    ((define-test (name formal ...) body-exp1 body-exp2 ...)
     (let ((proc (lambda (formal ...) body-exp1 body-exp2 ...)))
       (register-test
	(make-single-test 'name proc (detect-docstring (quote body-exp1))))))
    ((define-test () body-exp1 body-exp2 ...)
     (let ((proc (lambda () body-exp1 body-exp2 ...)))
       (register-test
	(make-single-test (generate-test-name) proc (detect-docstring (quote body-exp1))))))
    ((define-test form)
     (let ((proc (lambda () form)))
       (register-test
	(make-single-test (generate-test-name) proc (quote form)))))))

(define-syntax define-each-test
  (syntax-rules ()
    ((define-each-test form ...)
     (begin (define-test form) ...))))

(define-syntax define-each-check
  (syntax-rules ()
    ((define-each-check form ...)
     (begin (define-test () (check form)) ...))))

;;;; Test Running

;; Poor man's dynamic dispatch by storing the
;; procedures that do the job in a record
(define (run-given-test test-runner test)
  ((tr:run-one test-runner) (list (st:name test)) test))

(define (run-given-group test-runner group name-stack)
  ((tr:run-group test-runner) group name-stack))

(define (run-given-test-or-group test-runner test name-stack)
  (cond ((test-group? test)
	 (run-given-group test-runner test name-stack))
	((single-test? test)
	 (run-given-test test-runner test))
	(else
	 (error "Unknown test type" test))))

(define (report-results test-runner)
  ((tr:report-results test-runner)))

;; Allows access to old test results if needed and keeps failure
;; continuations from getting garbage collected.
(define *last-test-runner* #f)

(define (run-test test-name-stack . opt-test-runner)
  (let-optional opt-test-runner ((test-runner (make-standard-test-runner)))
   (let loop ((test (current-test-group))
	      (stack-left test-name-stack)
	      (stack-traversed '()))
     (cond ((null? stack-left)
	    (run-given-test-or-group test-runner test (reverse stack-traversed)))
	   ((test-group? test)
	    (tg:in-group-context test
	     (lambda ()
	       (tg:in-test-context test
		(lambda ()
		  (loop (tg:get test (car stack-left))
			(cdr stack-left)
			(cons (car stack-left) stack-traversed)))))))
	   (else
	    (error "Name stack did not lead to a valid test" test-name-stack))))
   (set! *last-test-runner* test-runner)
   (report-results test-runner)))

(define (run-registered-tests . opt-test-runner)
  (apply run-test (cons '() opt-test-runner)))

(define (clear-registered-tests!)
  (tg:clear! (current-test-group)))
