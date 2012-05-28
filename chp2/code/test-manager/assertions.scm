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

(define (ensure-forced object)
  (if (promise? object)
      (force object)
      object))

(define (instantiate-template template arguments)
  (if (not (= (length arguments) (- (length template) 1)))
      (error "Template and argument lists are length-mismatched: "
	     template arguments))
  (let loop ((result (car template))
	     (template (cdr template))
	     (arguments arguments))
    (if (null? template)
	result
	(loop (string-append result (car arguments) (car template))
	      (cdr template)
	      (cdr arguments)))))

(define (messagify object)
  (with-output-to-string (lambda () (display object))))

(define (build-message header template . arguments)
  (delay 
    (let ((body (instantiate-template template (map messagify arguments))))
      (if header
	  (string-append (messagify (ensure-forced header)) "\n" body)
	  (string-append "\n" body)))))

(define (assert-proc message proc)
  (if (proc)
      'ok
      (test-fail (messagify (ensure-forced message)))))

(define (assert-equivalent predicate . opt-pred-name)
  (define (full-message message expected actual)
    (if (null? opt-pred-name)
	(build-message message
		       '("<" "> expected but was\n<" ">.")
		       expected actual)
	(build-message message
		       '("<" "> expected to be " " to\n<" 
			 ">.")
		       expected (car opt-pred-name) actual)))
  (lambda (expected actual . opt-message)
    (let-optional 
     opt-message ((message #f))
     (assert-proc (full-message message expected actual)
		  (lambda () (predicate expected actual))))))

(define assert-eq (assert-equivalent eq? "eq?"))
(define assert-eqv (assert-equivalent eqv? "eqv?"))
(define assert-equal (assert-equivalent equal? "equal?"))
(define assert-= (assert-equivalent = "="))
(define assert-equals assert-equal)
(define assert= assert-=)
(define assert-< (assert-equivalent < "<"))
(define assert-> (assert-equivalent > ">"))
(define assert-<= (assert-equivalent <= "<="))
(define assert->= (assert-equivalent >= ">="))

(define (assert-in-delta expected actual delta . opt-message)
  (let-optional opt-message ((message #f))
   (let ((full-message
	  (build-message message '("<" "> and\n<" "> expected to be within\n<"
				   "> of each other.")
			 expected actual delta)))
     (assert-proc full-message (lambda () (<= (abs (- expected actual)) delta))))))

(define (assert-matches regexp string . opt-message)
  (let-optional opt-message ((message #f))
   (let ((full-message
	  (build-message message '("<" "> expected to match <" ">")
			 string regexp)))
     (assert-proc full-message
		  (lambda ()
		    (generic-match regexp string))))))

;; TODO how repetitive!
(define (assert-no-match regexp string . opt-message)
  (let-optional opt-message ((message #f))
   (let ((full-message
	  (build-message message '("<" "> expected not to match <" ">")
			 string regexp)))
     (assert-proc full-message
		  (lambda ()
		    (not (generic-match regexp string)))))))

(define (assert-true thing . opt-message)
  (let-optional opt-message ((message #f))
   (let ((full-message
	  (build-message message '("<" "> expected to be a true value.")
			 thing)))
     (assert-proc full-message (lambda () thing)))))

(define (assert-false thing . opt-message)
  (let-optional opt-message ((message #f))
   (let ((full-message
	  (build-message message '("<" "> expected to be a false value.")
			 thing)))
     (assert-proc full-message (lambda () (not thing))))))
