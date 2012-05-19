;;; 47-semaphore-using-mutex.scm

(load "p217-make-mutex.scm")

(define (make-semaphore n)

    (let ((mutex (make-mutex)))
        
        (define (acquire)
            (mutex 'acquire)
            (if (> n 0)                     ; 用互斥元保护 n 的修改
                (begin (set! n (- n 1))     ; 获取信号量之后
                       (mutex 'release)     ; 释放互斥元
                       'ok)
                (begin (mutex 'release)     ; 获取信号量不成功，先释放互斥元
                       (acquire))))         ; 然后再次尝试获取信号量

        (define (release)
            (mutex 'acquire)
            (set! n (+ n 1))                ; release 操作也需要用互斥元保护
            (mutex 'release)
            'ok)

        (define (dispatch mode)
            (cond ((eq? mode 'acquire)
                    (acquire))
                  ((eq? mode 'release)
                    (release))
                  (else
                    (error "Unknown mode MAKE-SEMAPHORE" mode))))

        dispatch))
