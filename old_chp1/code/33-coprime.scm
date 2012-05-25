;;; 33-coprime.scm

(define (coprime? i n)
    (and (< i n)
         (= 1 (gcd i n))))
