;;; 27-carmichael-test.scm

(load "p34-expmod.scm")

(define (carmichael-test n)
    (test-iter 1 n))

(define (test-iter a n)
    (cond ((= a n)
            #t)
          ((congruent? a n)
            (test-iter (+ a 1) n))
          (else
            #f)))

(define (congruent? a n)           ; 同余检测
    (= (expmod a n n) a))
