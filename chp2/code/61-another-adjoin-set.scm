;;; 61-another-adjoin-set.scm

(load "62-union-set.scm")

(define (adjoin-set x set)
    (union-set (list x) set))
