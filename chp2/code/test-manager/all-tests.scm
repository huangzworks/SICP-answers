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

(define-test (test-structure-smoke)
  (let ((mock-test-group (make-test-group 'mockery)))
    (with-top-level-group 
     mock-test-group
     (lambda ()
       (define-test (foo)
	 foo!)))
    (assert-= 1 (tg:size mock-test-group))
    (assert-true (single-test? (tg:get mock-test-group '(foo))))))

(define-test (test-structure)
  (let ((mock-test-group (make-test-group 'mockery)))
    (with-top-level-group 
     mock-test-group
     (lambda ()
       (in-test-group
	subgroup-1
	(define-test (some-name) foo!)
	(define-test (repeated-name) bar!))
       (in-test-group
	subgroup-2
	(define-test (some-other-name) baz!)
	(define-test (repeated-name) quux!))))
    (assert-= 2 (tg:size mock-test-group))
    (assert-true (test-group? (tg:get mock-test-group '(subgroup-1))))
    (assert-true (test-group? (tg:get mock-test-group '(subgroup-2))))
    (let ((fetched-tests
	   (map (lambda (test-path)
		  (assert-eq (tg:get mock-test-group test-path)
			     (tg:get mock-test-group test-path))
		  (tg:get mock-test-group test-path))
		'((subgroup-1 some-name)
		  (subgroup-1 repeated-name)
		  (subgroup-2 some-other-name)
		  (subgroup-2 repeated-name)))))
      (for-each (lambda (test)
		  (assert-true (single-test? test)))
		fetched-tests))
    (assert-false
     (eq? (tg:get mock-test-group '(subgroup-1 repeated-name))
	  (tg:get mock-test-group '(subgroup-2 repeated-name))))))

(in-test-group
 event-tracking-tests
 (let ((mock-test-group (make-test-group 'mockery))
       (events '()))
   (define (add-event event)
     (set! events (cons event events)))
   (define-set-up
     (set! events '())
     (set! mock-test-group (make-test-group 'mockery))
     (with-top-level-group 
      mock-test-group
      (lambda ()
	(define-group-surround
	  (add-event 'top-group-surround-begin)
	  (run-test)
	  (add-event 'top-group-surround-end))
	(define-group-set-up (add-event 'top-group-set-up))
	(define-group-tear-down (add-event 'top-group-tear-down))
	(define-surround
	  (add-event 'top-surround-begin)
	  (run-test)
	  (add-event 'top-surround-end))
	(define-set-up (add-event 'top-set-up))
	(define-tear-down (add-event 'top-tear-down))
	(in-test-group
	 group-a
	 (define-group-surround
	   (add-event 'a-group-surround-begin)
	   (run-test)
	   (add-event 'a-group-surround-end))
	 (define-group-set-up (add-event 'a-group-set-up))
	 (define-group-tear-down (add-event 'a-group-tear-down))
	 (define-surround
	   (add-event 'a-surround-begin)
	   (run-test)
	   (add-event 'a-surround-end))
	 (define-set-up (add-event 'a-set-up))
	 (define-tear-down (add-event 'a-tear-down))
	 (define-test (test-a1)
	   (add-event 'test-a1)
	   (assert-= 5 (+ 2 2)))
	 (define-test (test-a2)
	   (add-event 'test-a2)
	   (assert-equal '() #f)))
	(in-test-group
	 group-b
	 (define-group-surround
	   (add-event 'b-group-surround-begin)
	   (run-test)
	   (add-event 'b-group-surround-end))
	 (define-group-set-up (add-event 'b-group-set-up))
	 (define-group-tear-down (add-event 'b-group-tear-down))
	 (define-surround
	   (add-event 'b-surround-begin)
	   (run-test)
	   (add-event 'b-surround-end))
	 (define-set-up (add-event 'b-set-up))
	 (define-tear-down (add-event 'b-tear-down))
	 (define-test (test-b1)
	   (add-event 'test-b1)
	   (foo))
	 (define-test (test-b2)
	   (add-event 'test-b2)
	   (assert-= 4 (+ 2 (/ 2 0))))))))
   (define-test (test-running)
     (let ((result-string
	    (with-output-to-string
	      (lambda ()
		(with-top-level-group
		 mock-test-group
		 (lambda ()
		   (run-registered-tests)))))))
       (assert-matches
	"4 tests, 2 failures, 2 errors"
	result-string))
     (assert-equal
      ;; Beware, the indentation in this list was produced manually
      '(top-group-surround-begin top-group-set-up
	top-surround-begin top-set-up
	 a-group-surround-begin a-group-set-up
	  a-surround-begin a-set-up test-a1 a-tear-down a-surround-end
	  a-surround-begin a-set-up test-a2 a-tear-down a-surround-end
	 a-group-tear-down a-group-surround-end
	top-tear-down top-surround-end
	top-surround-begin top-set-up
	 b-group-surround-begin b-group-set-up
	  b-surround-begin b-set-up test-b1 b-tear-down b-surround-end
	  b-surround-begin b-set-up test-b2 b-tear-down b-surround-end
	 b-group-tear-down b-group-surround-end
	top-tear-down top-surround-end
	top-group-tear-down top-group-surround-end)
      (reverse events)))
   (define-test (test-running-one-test)
     (let ((result-string
	    (with-output-to-string
	      (lambda ()
		(with-top-level-group
		 mock-test-group
		 (lambda ()
		   (run-test '(group-b test-b1))))))))
       (assert-matches
	"1 tests, 0 failures, 1 errors"
	result-string))
     (assert-equal
      ;; Beware, the indentation in this list was produced manually
      '(top-group-surround-begin top-group-set-up
	top-surround-begin top-set-up
	 b-group-surround-begin b-group-set-up
	  b-surround-begin b-set-up test-b1 b-tear-down b-surround-end
	 b-group-tear-down b-group-surround-end
	top-tear-down top-surround-end
	top-group-tear-down top-group-surround-end)
      (reverse events)))
   (define-test (test-running-one-group)
     (let ((result-string
	    (with-output-to-string
	      (lambda ()
		(with-top-level-group
		 mock-test-group
		 (lambda ()
		   (run-test '(group-a))))))))
       (assert-matches
	"2 tests, 2 failures, 0 errors"
	result-string))
     (assert-equal
      ;; Beware, the indentation in this list was produced manually
      '(top-group-surround-begin top-group-set-up
	top-surround-begin top-set-up
	 a-group-surround-begin a-group-set-up
	  a-surround-begin a-set-up test-a1 a-tear-down a-surround-end
	  a-surround-begin a-set-up test-a2 a-tear-down a-surround-end
	 a-group-tear-down a-group-surround-end
	top-tear-down top-surround-end
	top-group-tear-down top-group-surround-end)
      (reverse events)))))

;; TODO test error behavior, particularly of run-test

(let ((entered-group #f))
  (in-test-group
   a-test-group-with-surroundings
   (set-tg:group-set-up! (current-test-group)
			 (lambda ()
			   (set! entered-group #t)))
   (define-test (check-enter-this-thunk-runs)
     (assert-eq #t entered-group))))

(define (run-test-capturing-output name-stack)
  (with-output-to-string
    (lambda ()
      (run-test name-stack))))

(define-test (test-explicit-run)
  (let ((count1 0)
	(count2 0)
	(mock-test-group (make-test-group 'mockery)))
    (with-top-level-group
     mock-test-group
     (lambda ()
       (in-test-group 
	sub1
	(in-test-group
	 sub2
	 (define-test (test1)
	   (set! count1 (+ count1 1)))
	 (define-test (test2)
	   (set! count2 (+ count2 1)))))
       (assert-= 0 count1)
       (assert-= 0 count2)
       (run-test-capturing-output '(sub1 sub2 test1))
       (assert-= 1 count1)
       (assert-= 0 count2)
       (run-test-capturing-output '(sub1 sub2))
       (assert-= 2 count1)
       (assert-= 1 count2)
       (run-test-capturing-output '(sub1 sub2 test2))
       (assert-= 2 count1)
       (assert-= 2 count2)))))

(define-test (test-anonymous-syntax)
  (let ((mock-test-group (make-test-group 'mockery)))
    (with-top-level-group
     mock-test-group
     (lambda ()
       (define-test ()
	 (this is an anonymous test))
       (define-test (so is this))))
    (assert-equal 2 (tg:size mock-test-group))))

(define-test (test-many-anonymous-syntax)
  (let ((mock-test-group (make-test-group 'mockery)))
    (with-top-level-group
     mock-test-group
     (lambda ()
       (define-each-test)
       (define-each-test 
	 (foo)
	 (bar)
	 (baz))))
    (assert-equal 3 (tg:size mock-test-group))))

(define-test (test-docstrings)
  (with-top-level-group
   (make-test-group 'mockery)
   (lambda ()
     (define-test (foo)
       "This is the foo docstring"
       (assert-true #t))
     (define-test (bar)
       "This is the bar docstring"
       (assert-true #f))
     (define-test (assert-false #f))
     (define-test (assert-false #t))
     (assert-matches
      "This is the bar docstring"
      (run-test-capturing-output '(bar)))
     (assert-no-match
      "This is the foo docstring"
      (run-test-capturing-output '(foo)))
     (assert-matches
      "(assert-false #t)"
      (run-test-capturing-output '()))
     (assert-no-match
      "(assert-false #f)"
      (run-test-capturing-output '())))))

(define-test (test-definition-clearing)
  (let ((mock-group (make-test-group 'mockery)))
    (with-top-level-group
     mock-group
     (lambda ()
       (define-test (foo) quux)
       (define-test (bar) baz)
       (define-test (ninja) monkey)))
    (assert= 3 (tg:size mock-group))
    (assert-true (single-test? (tg:get mock-group '(foo))))
    (assert-true (single-test? (tg:get mock-group '(bar))))
    (assert-true (single-test? (tg:get mock-group '(ninja))))
    (omap:remove! (tg:test-map mock-group) 'foo)
    (assert= 2 (tg:size mock-group))
    (assert-false (tg:get mock-group '(foo)))
    (assert-true (single-test? (tg:get mock-group '(bar))))
    (assert-true (single-test? (tg:get mock-group '(ninja))))
    (with-top-level-group
     mock-group
     (lambda ()
       (clear-registered-tests!)))
    (assert= 0 (tg:size mock-group))
    (assert-false (tg:get mock-group '(foo)))
    (assert-false (tg:get mock-group '(bar)))
    (assert-false (tg:get mock-group '(ninja)))))

(define-test (test-assert-generation)
  (with-top-level-group
   (make-test-group 'mockery)
   (lambda ()
     (define-test (foo)
       (assert-equal 2 3))
     (assert-matches
      "<2> expected to be equal\\? to\n<3>"
      (run-test-capturing-output '(foo))))))

(define-test (test-delayed-computation)
  (with-top-level-group
   (make-test-group 'mockery)
   (lambda ()
     (define-test (passing-does-not-trigger-delays)
       (assert-equal 2 2 (delay (pp "Should not happen"))))
     (define-test (failing-does-trigger-delays)
       (assert-equal 2 3 (delay (pp "Should happen"))))
     (assert-matches
      "1 tests, 0 failures, 0 errors"
      (run-test-capturing-output '(passing-does-not-trigger-delays)))
     (assert-no-match
      "happen"
      (run-test-capturing-output '(passing-does-not-trigger-delays)))
     (assert-matches
      "happen"
      (run-test-capturing-output '(failing-does-trigger-delays)))
     (assert-matches
      "1 tests, 1 failures, 0 errors"
      (run-test-capturing-output '(failing-does-trigger-delays))))))

(define-test (test-check-captures-info)
  (with-top-level-group
   (make-test-group 'mockery)
   (lambda ()
     (let ((foo 7) (bar 8))
       (define-test (arguments-for-check)
	 (check (> foo bar))))
     (assert-matches
      "1 tests, 1 failures, 0 errors"
      (run-test-capturing-output '(arguments-for-check)))
     (assert-matches
      "(> foo bar)"
      (run-test-capturing-output '(arguments-for-check)))
     (assert-matches
      "(7 8)"
      (run-test-capturing-output '(arguments-for-check))))))

(define-test (test-define-each-check)
  (with-top-level-group
   (make-test-group 'mockery)
   (lambda ()
     (in-test-group subgroup
      (define-each-check
	(even? (* 2 3))
	(odd? (* 4 3))
	(even? (+ 6 1))
	(odd? (+ 8 1))))
     (assert-matches
      "4 tests, 2 failures, 0 errors"
      (run-test-capturing-output '(subgroup)))
     (check (string-search-forward
	     "(odd? (* 4 3))"
	     (run-test-capturing-output '(subgroup))))
     (assert-matches
      "(12)"
      (run-test-capturing-output '(subgroup)))
     (check (string-search-forward
	     "(even? (+ 6 1))"
	     (run-test-capturing-output '(subgroup))))
     (assert-matches
      "(7)"
      (run-test-capturing-output '(subgroup))))))

(define-test (interactions)
  (interaction
   (define foo 5)
   (+ foo 2)
   (produces 7)
   ((if (even? 4) * +) 3 5)
   (produces 15)))

;; MIT Scheme specific features
(cond-expand
 (guile
  'ok)
 (else
  (load-relative "mit-scheme-tests")))
