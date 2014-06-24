;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-25
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.22

;; the following test is exactly the same thing as in ex-4.6
;; except the mimic interpretator and the global environment

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load modified EVAL procedure and let expression handles
(load "ex-4-22.scm")

;; define the global environment
(define the-global-environment-opt (setup-environment))

;; test the following let expression
;; (let ((a 1) (b 2)) (cons a b))
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE : (let ((a 1) (b 2)) (cons a b))")
(newline)
(display ";;; you should see : (1 . 2)")
(newline)
(display ";;; TYPE : (let () (cons 'a 'b))")
(newline)
(display ";;; you should see : (a . b)")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the mimic interpretator
(opt-driver-loop)
