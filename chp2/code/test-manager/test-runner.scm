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

(define-record-type <test-runner>
  (make-test-runner x y z)
  test-runner?
  (x tr:run-one)
  (y tr:run-group)
  (z tr:report-results))

;; TODO This currying is kind of nasty, but preferable to a single global
;; *test-result-map*.  Is there a way to get around this nastiness and
;; preserve a reasonable api for these functions?
(define ((standard-run-one-test result-map) test-name-stack test)
  (let ((test-result (capture-unhandled-errors (st:thunk test))))
    (cond
     ((and (condition? test-result)
	   (condition/test-failure? test-result))
      (omap:put! result-map test-name-stack test-result)
      (display "F"))
     ((and (condition? test-result)
	   (condition/error? test-result))
      (omap:put! result-map test-name-stack test-result)
      (display "E"))
     (else (omap:put! result-map test-name-stack 'pass)
	   (display ".")))))

(define ((standard-run-test-group result-map) group name-stack)
  (define (run-test-in-context name test)
    (tg:in-test-context group
     (lambda ()
       (if (single-test? test)
	   ((standard-run-one-test result-map)
	    (cons name name-stack) test)
	   ((standard-run-test-group result-map)
	    test (cons name name-stack))))))
  (tg:in-group-context group
   (lambda ()
     (omap:for-each
      (tg:test-map group)
      run-test-in-context))))

(define ((standard-report-results result-map))
  (newline) ; Finish the run-one-test wallpaper
  (let ((passes 0)
	(failures 0)
	(errors 0))
    (define (report-misbehavior kind test-name-stack condition)
      (display "  ")
      (display (+ failures errors))
      (display ") ")
      (display kind)
      (display " (")
      (display (condition/continuation condition))
      (display "): ")
      (newline)
      (display (reverse test-name-stack))
      (display ": ")
      (newline)
      ;; TODO Oh, what a mess!
      (let ((test (tg:get (current-test-group) (reverse test-name-stack))))
	(if test
	    (let ((docstring (st:docstring test)))
	      (if docstring
		  (if (string? docstring)
		      (begin (display docstring) (newline))
		      (pp docstring))))))
      (write-condition-report condition (current-output-port))
      (newline)
      (newline))
    (newline)
    (omap:for-each
     result-map
     (lambda (test-name-stack result)
       (cond
	((and (condition? result)
	      (condition/test-failure? result))
	 (set! failures (+ failures 1))
	 (report-misbehavior "Failure" test-name-stack result))
	((and (condition? result)
	      (condition/error? result))
	 (set! errors (+ errors 1))
	 (report-misbehavior "Error" test-name-stack result))
	((eq? 'never-ran result))	; Skip tests that haven't run
	(else
	 (set! passes (+ passes 1))))))
    
    (display (+ passes failures errors))
    (display " tests, ")
    (display failures)
    (display " failures, ")
    (display errors)
    (display " errors.")
    (newline)
    (+ failures errors)))

(define (make-standard-test-runner)
  (let ((result-map (make-ordered-map)))
    (make-test-runner (standard-run-one-test result-map)
		      (standard-run-test-group result-map)
		      (standard-report-results result-map))))
