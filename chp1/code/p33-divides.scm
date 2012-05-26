;;; p33-divides.scm

(define (divides? a b)
    (= (remainder b a) 0))
