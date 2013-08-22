;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-22
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.20

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load 'and' and 'or' handles
(load "ex-4-04.scm")

;; load modified EVAL procedure and let expression handles
(load "ex-4-06.scm")

;; load modified EVAL procedure based on ex 4.6 and letrec handles
(load "ex-4-20.scm")

;; add primitive operator '+' '-' and '='
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '> >)
        (list '= =)
        (list '- -)
        (list 'number? number?)
        (list 'display display)))

;; define the global environment
(define the-global-environment (setup-environment))

;; define a function that test a number is even or odd
;; or simply not a number
(eval
 '(define (f x)
    (letrec ((even? (lambda (n)
                      (if (= n 0)
                          true
                          (odd? (- n 1)))))
             (odd? (lambda (n)
                     (if (= n 0)
                         false
                         (even? (- n 1))))))
      (if (and (number? x) (or (> x 0) (= x 0)))
          (if (odd? x)
              (begin (display "this is an odd number") x)
              (if (even? x)
                  (begin (display "this is an even number") x)))
          (begin (display "this is not an nonnegative integer number") x))))
 the-global-environment)

;; use let instead of letrec
(eval
 '(define (f-let x)
    (let ((even? (lambda (n)
                   (if (= n 0)
                       true
                       (odd? (- n 1)))))
          (odd? (lambda (n)
                  (if (= n 0)
                      false
                      (even? (- n 1))))))
      (if (and (number? x) (or (> x 0) (= x 0)))
          (if (odd? x)
              (begin (display "this is an odd number") x)
              (if (even? x)
                  (begin (display "this is an even number") x)))
          (begin (display "this is not an nonnegative integer number") x))))
 the-global-environment)

;; test the following expressions
;; (f 8)
;; (f 9)
;; (f-let 0)
;; (f-let 5)
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE : (f 8)")
(newline)
(display ";;; you should see : this is an even number")
(newline)
(display ";;; TYPE : (f 9)")
(newline)
(display ";;; you should see : this is an odd number")
(newline)
(display ";;; TYPE : (f-let 0)")
(newline)
(display ";;; you should see : this is an even number")
(newline)
(display ";;; TYPE : (f-let 5)")
(newline)
(display ";;; you should see : Unbound variable even?")
(newline)
(display ";;; Q1: why (f-let 0) works but any other positive number don't work?")
(newline)
(display ";;; Hint: think about recursion binding.")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the mimic interpretator
(driver-loop)

