;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.7

;; load all the original necessary procedures in the text book

(load "chpt-4-1.scm")

;; load modified EVAL procedure and let expression handles

(load "ex-4-07.scm")

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '* *)
        (list '+ +)))

;; define the global environment

(define the-global-environment (setup-environment))

;; test the following let expression
;; (let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z))

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE :")
(newline)
(display ";;; (let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z))")
(newline)
(display ";;; you should see : 39")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the mimic interpretator
(driver-loop)
