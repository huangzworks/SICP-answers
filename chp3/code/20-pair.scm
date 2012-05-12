;;; 20-pair.scm

(define cons
    (lambda (x y)
        (define set-x!
            (lambda (v)
                (set! x v)))
        (define set-y!
            (lambda (v)
                (set! y v)))
        (define dispatch
            (lambda (m)
                (cond ((eq? m 'car)
                        x)
                      ((eq? m 'cdr)
                        y)
                      ((eq? m 'set-car!)
                        set-x!)
                      ((eq? m 'set-cdr!)
                        set-y!)
                      (else
                        (error "Undefined operation -- CONS" m)))))
        dispatch))

(define car
    (lambda (z)
        (z 'car)))

(define cdr
    (lambda (z)
        (z 'cdr)))

(define set-car!
    (lambda (z new-value)
        ((z 'set-car!) new-value)))

(define set-cdr!
    (lambda (z new-value)
        ((z 'set-cdr!) new-value)))
