;;; 29-branch-torque.scm

(load "29-branch-length-and-branch-structure.scm")  ; 载入 branch-length
(load "29-total-weight.scm")                        ; 载入 branch-weight

(define (branch-torque branch)
    (* (branch-length branch)
       (branch-weight branch)))
