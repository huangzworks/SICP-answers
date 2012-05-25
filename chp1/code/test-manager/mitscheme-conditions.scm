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

;;; These are the definitions that are actively intertwined with MIT
;;; Scheme's condition system, which this test manager originally
;;; used.  They are replaced by equivalent (I hope) domain-specific
;;; definitions tailored for other condition systems in other
;;; *-conditions.scm files.

(define condition-type:test-failure
  (make-condition-type 'test-failure condition-type:error
		       '(message) (lambda (condition port)
				    (display (access-condition condition 'message) port))))

(define condition/test-failure?
  (condition-predicate condition-type:test-failure))

(define test-fail
  (condition-signaller condition-type:test-failure
		       '(message) standard-error-handler))

;;; Gaah!  The signaling of a condition in a flexible language like
;;; Scheme does not, unlike the raising of an exception in Java,
;;; entail that the code signaling the condition failed.  In fact, it
;;; is quite possible that the condition will be handled by some
;;; toplevel condition handler in a manner that will cause the
;;; underlying code to continue, and eventually produce a normal
;;; return.  For example, Mechanics allows vectors to be applied by
;;; just such a mechanism.  The unit test framework must,
;;; consequently, try its best to allow such shenanigans to succeed,
;;; without disrupting the operation of the test framework itself.
;;; Hence the ugliness below.
;;; TODO Port this crap to Guile
(define (capture-unhandled-errors thunk)
  (if standard-error-hook
      ;; Fix this for the test-within-a-test case.
      (warn "If the standard error hook is already bound, I can't be sure which errors are unhandled."))
  (call-with-current-continuation
   (lambda (k)
     (fluid-let ((standard-error-hook k))
       (thunk)))))
