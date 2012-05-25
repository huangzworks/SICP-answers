;;; 3-bigger-square-sum.scm

(load "3-bigger-and-smaller.scm")
(load "3-square-sum.scm")

(define (bigger-square-sum x y z)
    (square-sum (bigger x y)                ; bigger
                (bigger (smaller x y) z)))  ; another bigger
