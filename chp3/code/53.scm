;;; 53.scm

(load "p228-add-streams.scm")

(define s (cons-stream 1 (add-streams s s)))
