;;; 4-cdr.scm

(define (cdr z)
    (z (lambda (p q) q)))
