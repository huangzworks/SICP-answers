;;; p48-average-damp.scm

(load "p15-average.scm")

(define (average-damp f)
    (lambda (x)
        (average x 
                 (f x))))
