;;; 37-transpose.scm

(load "36-accumulate-n.scm")

(define (transpose m)
    (accumulate-n cons '() m))
