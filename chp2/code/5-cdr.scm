;;; 5-cdr.scm

(define (cdr z)
    (if (= 0 (remainder z 3))
        (+ 1 (cdr (/ z 3)))
        0))
