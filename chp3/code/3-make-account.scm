;;; 3-make-account.scm

(define (make-account blance password)

    (define (withdraw amount)
        (if (>= blance amount)
            (begin (set! blance (- blance amount))
                   blance)
            "Insufficient funds"))

    (define (deposit amount)
        (set! blance (+ blance amount)))

    (define (password-match? given-password)                            ; 新增
            (eq? given-password password))                              ;

    (define (display-wrong-password-message useless-arg)                ; 新增
        (display "Incorrect password"))                                 ;

    (define (dispatch given-password mode)          
        (if (password-match? given-password)                            ; 新增
            (cond ((eq? mode 'withdraw)
                    withdraw)
                  ((eq? mode 'deposit)
                    deposit)
                  (else
                    (error "Unknow request -- MAKE-ACCOUNT" mode)))
            display-wrong-password-message))                            ; 新增

    dispatch)
