;;; 45-average-damp-n-times.scm

(load "43-repeated.scm")
(load "p48-average-damp.scm")

(define (average-damp-n-times f n)
    ((repeated average-damp n) f))
