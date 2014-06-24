;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-23
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.21

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load modified EVAL procedure based on ex 4.6 and letrec handles
(load "ex-4-21.scm")

;; add primitive operator '+' '-' and '='
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '= =)
        (list '+ +)
        (list '- -)
        (list '* *)))

;; define the global environment
(define the-global-environment (setup-environment))

;; define factorial procedure in our mimic interpretator
(eval
 '(define factorial-pure
    (lambda (n)
      ((lambda (fact)
         (fact fact n))
       (lambda (ft k)
         (if (= k 0)
             1
             (* k (ft ft (- k 1))))))))
 the-global-environment)

;; define Fibonacci procedure in our mimic interpretator
(eval
 '(define fibonacci-pure
    (lambda (n)
      ((lambda (fibonacci)
         (fibonacci fibonacci n))
       (lambda (fib k)
         (if (= k 1)
             1
             (if (= k 0)
                 0
                 (+ (fib fib (- k 1))
                    (fib fib (- k 2)))))))))
 the-global-environment)

;; define a procedure f which determines if a number is even.
(eval
 '(define (f x)
    ((lambda (even? odd?)
       (even? even? odd? x))
     (lambda (ev? od? n)
       (if (= n 0) true (od? ev? od? (- n 1))))
     (lambda (ev? od? n)
       (if (= n 0) false (ev? ev? od? (- n 1))))))
 the-global-environment)

;; test the following expressions
;; (factorial-pure 0)
;; (factorial-pure 1)
;; (factorial-pure 10)
;; (fibonacci-pure 0)
;; (fibonacci-pure 1)
;; (fibonacci-pure 10)
;; (f 0)
;; (f 1)
;; (f 19)
;; (f 48)
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE the following expressions in order")
(newline)
(display ";;; (factorial-pure 0)")
(newline)
(display ";;; (factorial-pure 1)")
(newline)
(display ";;; (factorial-pure 10)")
(newline)
(display ";;; (fibonacci-pure 0)")
(newline)
(display ";;; (fibonacci-pure 1)")
(newline)
(display ";;; (fibonacci-pure 10)")
(newline)
(display ";;; (f 0)")
(newline)
(display ";;; (f 1)")
(newline)
(display ";;; (f 19)")
(newline)
(display ";;; (f 48)")
(newline)
(display ";;; you should see in order : 1 1 3628800 0 1 55 #t #f #f #t")
(newline)
(display ";;; you can also test them in our mimic interpretator")
(newline)
(display ";;; note that in the test file we only load \"chpt-4-1.scm\"")
(newline)
(display ";;; which means no 'let', no let-variations")
(newline)
(display ";;; run (driver-loop) then re-type the previous expressions")
(newline)
(display ";;; you should see the same results")
(newline)
(display ";;; ******************** TEST ****************************************")
