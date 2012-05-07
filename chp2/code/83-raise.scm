;;; 83-raise.scm

(load "p125-apply-generic.scm")

(define (raise value)
    (apply-generic 'raise value))
