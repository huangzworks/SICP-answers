;;; 31-denom-term.scm

(define (denom-term i)
    (if (odd? i)
        (+ i 2)
        (+ i 1)))
