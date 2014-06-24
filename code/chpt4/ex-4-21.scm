;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-23
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.21
;;
;; It is indeed possible to specify recursive procedures
;; without using letrec (or even define), although the method for
;; accomplishing this is much more subtle than Louis imagined. The
;; following expression computes 10 factorial by applying a recursive
;; factorial procedure:27
;;
;; ((lambda (n)
;;    ((lambda (fact)
;;       (fact fact n))
;;     (lambda (ft k)
;;       (if (= k 1)
;;           1
;;           (* k (ft ft (- k 1)))))))
;;  10)
;;
;; a. Check (by evaluating the expression) that this really does
;; compute factorials. Devise an analogous expression for computing
;; Fibonacci numbers.
;;
;; b. Consider the following procedure, which includes mutually
;; recursive internal definitions:
;;
;; (define (f x)
;;   (define (even? n)
;;     (if (= n 0)
;;         true
;;         (odd? (- n 1))))
;;   (define (odd? n)
;;     (if (= n 0)
;;         false
;;         (even? (- n 1))))
;;   (even? x))
;;
;; Fill in the missing expressions to complete an alternative
;; definition of f, which uses neither internal definitions nor
;; letrec:
;;
;; (define (f x)
;;   ((lambda (even? odd?)
;;      (even? even? odd? x))
;;    (lambda (ev? od? n)
;;      (if (= n 0) true (od? <??> <??> <??>)))
;;    (lambda (ev? od? n)
;;      (if (= n 0) false (ev? <??> <??> <??>)))))
;;
;; =============================================================================


;; a
;; (fact fact n) pass the procedure 'fact' as an argument so it can be recursive
;; factorial procedure
(define factorial-pure
  (lambda (n)
    ((lambda (fact)
       (fact fact n))
     (lambda (ft k)
       (if (= k 0)
           1
           (* k (ft ft (- k 1))))))))

;; Fibonacci procedure
(define fibonacci-pure
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

;; b
;; ev? correspond even? od? correspond odd?
;; do NOT change their order to fill <??> <??> <??>
;; since both procedure even? and odd? keep the same order of their parameters
;; in fact, ev? and od? 's order should be the same as in even?
;; if they are used in ev? and be the same as in odd? if they used in od?
;; as they are just arguments which are passed to the next recursion
;; Here procedure even? and odd? mean the corresponding lambda expressions
(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))
