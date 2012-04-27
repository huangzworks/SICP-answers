;;; 27-carmichael-test.scm

(load "p34-fast-prime.scm")         ; 载入 expmod

(define (carmichael-test n)
    (test-iter 1 n))

(define (test-iter a n)
    (cond ((= a n)
            #t)
          ((congruence? a n)
            (test-iter (+ a 1) n))
          (else
            #f)))

(define (congruence? a n)           ; 同余检测
    (= (expmod a n n) a))
