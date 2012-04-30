;;; 17-last-pair.scm

(define (last-pair lst)
    (cond ((null? lst)
            '())
          ((null? (cdr lst))
            lst)
          (else
            (last-pair (cdr lst)))))
