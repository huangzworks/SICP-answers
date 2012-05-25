;;; 3-bigger-sum-of-squares.scm

(load "p8-sum-of-squares.scm")
(load "3-bigger-and-smaller.scm")

(define (bigger-sum-of-squares x y z)
    (sum-of-squares (bigger x y)                    ; bigger
                    (bigger (smaller x y) z)))      ; another bigger
