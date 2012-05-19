;;; p217-make-mutex.scm

(define (make-mutex)
    (let ((cell (list #f)))
        (define (the-mutex m)
            (cond ((eq? m 'acquire)
                    (if (test-and-set! cell)
                        (the-mutex 'acquire)))
                  ((eq? m 'release)
                    (clear! cell))))
        the-mutex))

(define (clear! cell)
    (set-car! cell #f))

(define (test-and-set! cell)
    (if (car cell)
        #t
        (begin (set-car! cell #t)
               #f)))
