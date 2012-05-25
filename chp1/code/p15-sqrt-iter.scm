;;; p15-sqrt-iter.scm

(load "p15-good-enough.scm")
(load "p15-improve.scm")

(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x)
                   x)))
