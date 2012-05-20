;;; 59-integrate-series.scm

(load "54-mul-streams.scm")
(load "59-div-streams.scm")
(load "p228-ones.scm")
(load "p228-integers.scm")

(define (integrate-series a)
    (mul-streams a                                  ; a0, a1, a2, ...
                 (div-streams ones integers)))      ; 1/1, 1/2, 1/3, ...
