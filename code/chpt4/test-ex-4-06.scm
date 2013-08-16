;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.6

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load modified EVAL procedure and let expression handles
(load "ex-4-06.scm")

;; define the global environment
(define the-global-environment (setup-environment))

;; test the following let expression
;; (let ((a 1) (b 2)) (cons a b))
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE :")
(newline)
(display ";;; (let ((a 1) (b 2)) (cons a b))")
(newline)
(display ";;; you should see : (1 . 2)")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the mimic interpretator
(driver-loop)
