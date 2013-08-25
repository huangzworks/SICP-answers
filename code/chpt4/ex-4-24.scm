;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-25
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.24
;;
;; Design and carry out some experiments to compare the speed of the
;; original metacircular evaluator with the version in this
;; section. Use your results to estimate the fraction of time that is
;; spent in analysis versus execution for various procedures.
;;
;; =============================================================================


;; we use the fibonacci procedure to test
(define fibonacci-exp
  '(define (fib n)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else (* (fib (- n 1))
                    (fib (- n 2)))))))

;; load the original eval procedure and optimized eval-opt procedure
(load "Chpt-4-1.scm")

;; add primitive operator '+' '-' and '='
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '= =)
        (list '- -)
        (list '* *)))

;; define the global environment for the original eval
(define the-global-environment-original (setup-environment))

;; define the global environment for the optmized eval-opt
(define the-global-environment-optimized (setup-environment))

;; define the factorial in the original interpretator
(eval fibonacci-exp the-global-environment-original)

;; define the factorial in the optimized interpretator
(eval-opt fibonacci-exp the-global-environment-optimized)

;; record the time needed in both original and optimized interpretator
(define (report-time elapsed-time)
  (display " *** ")
  (display elapsed-time)
  (display " seconds")
  (newline))

(newline)
(display ";; time test begins")
(newline)
(display ";; test original EVAL procedure")
(newline)

;; run (fib 20)
(let ((start-time (runtime)))
  (eval '(fib 20) the-global-environment-original)
      (report-time (- (runtime) start-time)))

(display ";; test optimized EVAL-OPT procedure")
(newline)

;; run (fib 20)
(let ((start-time (runtime)))
  (eval-opt '(fib 20) the-global-environment-optimized)
      (report-time (- (runtime) start-time)))

(display ";; time test ends")
(newline)
