;;; p49-newton-transform.scm

(load "p49-deriv.scm")

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))
