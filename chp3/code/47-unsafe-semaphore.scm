;;; 47-unsafe-semaphore.scm

(define (make-semaphore n)

    (define (acquire)
        (if (> n 0)
            (begin (set! n (- n 1))
                   'ok)
            (acquire)))

    (define (release)
        (set! n (+ n 1))
        'ok)

    (define (dispatch mode)
        (cond ((eq? mode 'acquire)
                (acquire))
              ((eq? mode 'release)
                (release))
              (else
                (error "Unknown mode MAKE-SEMAPHORE" mode))))

    dispatch)
