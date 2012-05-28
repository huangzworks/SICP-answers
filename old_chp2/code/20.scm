;;; 20.scm

(define (same-parity sample . others)
    (filter (if (even? sample)
                even?
                odd?)
            (cons sample others)))
