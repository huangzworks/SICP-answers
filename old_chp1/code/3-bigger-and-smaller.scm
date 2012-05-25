;;; 3-bigger-and-smaller.scm

(define (bigger x y)
    (if (> x y)
        x
        y))

(define (smaller x y)
    (if (> x y)
        y
        x))
