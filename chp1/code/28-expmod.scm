;;; 28-expmod.scm

(load "28-nontrivial-square-root.scm")

(define (expmod base exp m)
    (cond ((= exp 0)
            1)
          ((nontrivial-square-root? base m)                 ; 新增
            0)                                              ;
          ((even? exp)
            (remainder (square (expmod base (/ exp 2) m))
                       m))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))
