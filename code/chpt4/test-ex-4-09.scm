;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-17
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.9

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load modified EVAL procedure and let expression handles
(load "ex-4-09.scm")

;; add primitive operator '+' '-' and '='
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'display display)
        (list '+ +)))

;; define the global environment
(define the-global-environment (setup-environment))

;; test the following let expression
;;
;; (let ((x '(1 3 5 7 9)))
;;  (do ((x x (cdr x))
;;       (sum 0 (+ sum (car x))))
;;      ((null? x) sum)))
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE :")
(newline)
(display ";;; (let ((x '(1 3 5 7 9)))")
(newline)
(display ";;;  (do ((x x (cdr x))")
(newline)
(display ";;;       (sum 0 (+ sum (car x))))")
(newline)
(display ";;;      ((null? x) sum)))")
(newline)
(display ";;; you should see : 25")
(newline)
(display ";;; ******************** TEST ****************************************")

(driver-loop)
