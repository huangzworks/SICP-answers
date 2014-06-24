;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-18
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.10

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load modified Frame (DATA Abstractions)
(load "ex-4-11.scm")

;; define the global environment
(define the-global-environment (setup-environment))

;; test the modified frame
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; You first modify an previous test-ex-4-?? file")
(newline)
(display ";;; add (load \"ex-4-11.scm\") just after (load \"chpt-4-1.scm\")")
(newline)
(display ";;; load the modified test-ex-4-?? file")
(newline)
(display ";;; then TYPE: (make-frame '(a b c) '(1 2 3)) in scheme's interpretor")
(newline)
(display ";;; to make sure the output is : ((a . 1) (b . 2) (c . 3))")
(newline)
(display ";;; which is a list of pair")
(newline)
(display ";;; then re-do that test, it should give the same result")
(newline)
(display ";;; ******************** TEST ****************************************")
