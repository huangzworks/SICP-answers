;;; 33-product-of-coprimes.scm

(load "33-coprime.scm")
(load "33-filtered-accumulate.scm")

(define (product-of-coprimes n)
    (filtered-accumulate *
                         1
                         (lambda (x) x)
                         1
                         (lambda (i) (+ i 1))
                         n
                         (lambda (x) (coprime? x n))))
