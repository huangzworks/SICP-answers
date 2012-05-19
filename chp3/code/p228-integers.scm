;;; p228-integers.scm

(load "p228-add-streams.scm")
(load "p228-ones.scm")

(define integers 
    (cons-stream 1 
                 (add-streams ones integers)))
