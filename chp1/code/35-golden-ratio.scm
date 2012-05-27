;;; 35-golden-ratio.scm

(load "p46-fixed-point.scm")

(define golden-ratio
    (fixed-point (lambda (x) 
                     (+ 1 (/ 1 x)))
                 1.0))
