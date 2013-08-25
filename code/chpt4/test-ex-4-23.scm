;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-25
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.23

;; we use the fibonacci procedure to compare
(define fibonacci-exp
  '(define (fib n)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else (* (fib (- n 1))
                    (fib (- n 2)))))))

;; load the original optimized eval-opt and alyssa's eval-alyssa
(load "chpt-4-1.scm")
(load "ex-4-23.scm")

;; add primitive operator '+' '-' and '='
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '= =)
        (list '- -)
        (list '* *)))

;; define the global environment for the optmized eval-opt
(define the-global-environment-opt (setup-environment))

;; define the global environment for the alyssa's eval-alyssa
(define the-global-environment-alyssa (setup-environment))

;; define the factorial in the optimized interpretator
(eval-opt fibonacci-exp the-global-environment-opt)

;; define the factorial in the optimized interpretator
(eval-alyssa fibonacci-exp the-global-environment-alyssa)

;; record the time needed in both original and optimized interpretator
(define (report-time elapsed-time)
  (display " *** ")
  (display elapsed-time)
  (display " seconds")
  (newline))

(newline)
(display ";; time test begins")
(newline)
(display ";; test text EVAL-OPT procedure")
(newline)

;; run (fib 22)
(let ((start-time (runtime)))
  (eval-opt '(fib 21) the-global-environment-optimized)
      (report-time (- (runtime) start-time)))

(display ";; test alyssa's EVAL-ALYSSA procedure")
(newline)

;; run (fib 21)
(let ((start-time (runtime)))
  (eval-alyssa '(fib 21) the-global-environment-alyssa)
      (report-time (- (runtime) start-time)))

(display ";; time test ends")
(newline)
