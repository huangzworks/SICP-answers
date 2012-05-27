;;; 41-double.scm

(define (double f)
    (lambda (x)
        (f (f x))))
