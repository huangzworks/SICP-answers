;;; 9-plus.scm

(load "9-inc.scm")
(load "9-dec.scm")

(define (plus a b)
    (if (= a 0)
        b
        (inc (plus (dec a) b))))
