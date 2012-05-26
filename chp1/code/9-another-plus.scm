;;; 9-another-plus.scm

(load "9-inc.scm")
(load "9-dec.scm")

(define (plus a b)
    (if (= a 0)
        b
        (plus (dec a) (inc b))))
