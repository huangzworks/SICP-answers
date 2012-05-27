;;; 37-golden-ratio.scm

(load "37-rec-cont-frac.scm")

(define (golden-ratio k)
    (+ 1
       (cont-frac (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k)))
