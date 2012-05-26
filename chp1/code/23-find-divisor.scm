;;; 23-find-divisor.scm

(load "23-next.scm")
(load "p33-divides.scm")

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n)
            n)
          ((divides? test-divisor n)
            test-divisor)
          (else
            (find-divisor n (next test-divisor)))))     ; 将 next 应用到这
