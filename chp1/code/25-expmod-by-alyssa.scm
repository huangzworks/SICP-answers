;;; 25-expmod-by-alyssa.scm

(load "16-fast-expt.scm")

(define (expmod base exp m)
    (remainder (fast-expt base exp) m))
