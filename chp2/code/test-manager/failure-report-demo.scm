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

(define-test (this-test-passes)
  (assert-eqv 4 (+ 2 2) "Two plus two isn't four."))

(define-test (this-test-fails)
  (assert-eqv 5 (+ 2 2) "Two plus two isn't five."))

(in-test-group
 a-test-group
 (define-test (happy-internal-test)
   (assert-= 12 (* 3 4) "Three by four should be twelve"))
 (define-test (unhappy-internal-test)
   (assert-equal '() #f "Nil and false are different"))
 (define-test (broken-internal-test)
   (foo))
 (let ((this-test-group *current-test-group*))
   (define-test (meta-internal-test)
     (assert-equal '(happy-internal-test unhappy-internal-test
					 broken-internal-test
					 meta-internal-test)
		   (omap:key-list (tg:test-map this-test-group))))))

(in-test-group
 failed-assertion-showcase
 (define-test (fail-generic-assert-equivalent)
   ((assert-equivalent (lambda (x y)
			 (or (eq? x y)
			     (and (list? x)
				  (list? y)))))
    #(a) #(f))))

(define-test (this-test-errors)
  (assert-eqv 4 (+ 2 (/ 2 0)) "Don't divide by zero."))

(define-test
  (error "Anonymous tests can fail too"))

(define-test (check-smoke)
  (check (< (+ 2 5) (* 3 2)) "There is a check macro that tries to DWIM."))

(define-test (check-error)
  (check (error "Errors can happen in checks.")))

(run-registered-tests)
