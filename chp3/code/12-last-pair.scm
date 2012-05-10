;;; 12-last-pair.scm

(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
