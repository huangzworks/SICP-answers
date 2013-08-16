;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.8

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load modified EVAL procedure and let expression handles
(load "ex-4-08.scm")

;; add primitive operator '+' '-' and '='
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '= =)
        (list '- -)
        (list '+ +)))

;; define the global environment
(define the-global-environment (setup-environment))

;; test the following expression
;; (define (fib n)
;;   (let fib-iter ((a 1)
;;                  (b 0)
;;                  (count n))
;;     (if (= count 0)
;;         b
;;         (fib-iter (+ a b) a (- count 1)))))

;; define the fib procedure with named let
(eval '(define (fib n)
         (let fib-iter ((a 1)
                        (b 0)
                        (count n))
           (if (= count 0)
               b
               (fib-iter (+ a b) a (- count 1)))))
      the-global-environment)

;; test the fib procedure defined with named let
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE : (fib n)")
(newline)
(display ";;; you should see the right fib number")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the mimic interpretator
(driver-loop)
