;;; p70-map.scm

(define (map p sequence)
    (if (null? sequence)
        '()
        (cons (p (car sequence))
              (map p (cdr sequence)))))
