;;; 31-rec-product.scm

(define (product term a next b)
    (if (> a b)
        1
        (* (term a)
           (product term (next a) next b))))
