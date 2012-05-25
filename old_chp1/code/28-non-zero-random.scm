;;; 28-non-zero-random.scm

(define (non-zero-random n)
    (let ((a (random n)))
        (if (not (= a 0))
            a
            (non-zero-random n))))
