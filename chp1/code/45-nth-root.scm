;;; 45-nth-root.scm

(load "45-damped-nth-root.scm")
(load "45-lg.scm")

(define (nth-root n)
    (damped-nth-root n (lg n)))
