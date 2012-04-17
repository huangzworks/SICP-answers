;;; 9-plus.scm

(define (inc n)
    (+ n 1))

(define (dec n)
    (- n 1))

(define (plus-1 a b)
    (if (= a 0)
        b
        (inc (plus-1 (dec a) b))))

(define (plus-2 a b)
    (if (= a 0)
        b
        (plus-2 (dec a) (inc b))))
