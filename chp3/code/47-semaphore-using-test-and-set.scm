;;; 47-semaphore-using-test-and-set.scm

(define (make-semaphore n)

    (define (acquire)
        (if (test-and-set! n)
            (acquire)
            'ok))
    
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

(define (test-and-set! n)
    (if (= n 0)
        #t
        (begin (set! n (- n 1))
               #f)))

#|
; 根据注释 174
; 以下是一个可以在采用时间片模型的单处理器的 MIT Scheme 里实际运行的 test-and-set!

(define (test-and-set! n)
    (without-interrupts
        (lambda ()
            (if (= n 0)
                #t
                (begin (set! n (- n 1))
                       #f)))))

|#
