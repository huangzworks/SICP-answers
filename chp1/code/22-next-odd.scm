;;; 22-next-odd.scm

(define (next-odd n)
    (if (odd? n)
        (+ 2 n)
        (+ 1 n)))
