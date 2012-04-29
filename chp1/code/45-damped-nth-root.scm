;;; 45-damped-nth-root.scm

(load "p46-fixed-point.scm")
(load "45-expt.scm")
(load "45-average-damp-n-times.scm")

(define (damped-nth-root n damp-times)
    (lambda (x)
        (fixed-point 
            (average-damp-n-times 
                (lambda (y) 
                    (/ x (expt y (- n 1)))) 
                damp-times)
            1.0)))
