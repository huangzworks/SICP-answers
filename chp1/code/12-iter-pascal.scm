;;; 12-iter-pascal.scm

(load "p22-iter-factorial.scm")

(define (pascal row col)
    (/ (factorial row)
       (* (factorial col)
          (factorial (- row col)))))
