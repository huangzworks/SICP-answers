;;; 34-horner-eval.scm

(load "p78-accumulate.scm")

(define (horner-eval x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms)
                    (+ this-coeff (* x higher-terms)))
                0
                coefficient-sequence))
