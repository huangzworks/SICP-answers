;;; 54.scm

(define (equal? x y)
    (if (and (symbol? x) (symbol? y))
        (eq? x y)
        (list-equal? x y)))

(define (list-equal? x y)
    (cond ((not (equal? (car x) (car y)))
            #f)
          ((null? (cdr x) (cdr y))
            #t)
          (else
            (equal? (cdr x) (cdr y)))))
