;;; p32-gcd.scm

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
