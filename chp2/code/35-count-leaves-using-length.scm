;;; 35-count-leaves-using-length.scm

(load "28-fringe.scm")

(define (count-leaves tree)
    (length (fringe tree)))
