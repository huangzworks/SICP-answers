;;; 4-make-account.scm

(define (make-account blance password)

    (let ((max-try-times 7)
          (try-times 0))

        (define (withdraw amount)
            (if (>= blance amount)
                (begin (set! blance (- blance amount))
                       blance)
                "Insufficient funds"))

        (define (deposit amount)
            (set! blance (+ blance amount)))

        (define (password-match? given-password)                         
                (eq? given-password password))                          

        (define (display-wrong-password-message useless-arg)                
            (display "Incorrect password"))                                

        (define (dispatch given-password mode)          
            (if (password-match? given-password)                          
                (begin
                    (set! try-times 0)                          ; 成功登录之后清零计数器
                    (cond ((eq? mode 'withdraw)
                            withdraw)
                          ((eq? mode 'deposit)
                            deposit)
                          (else
                            (error "Unknow request -- MAKE-ACCOUNT" mode))))
                (begin          
                    (set! try-times (+ 1 try-times))            ; 进行计数
                    (if (>= try-times max-try-times)
                        (call-the-cops)
                        display-wrong-password-message))))
    
        dispatch))

(define (call-the-cops)
    (error "You try too much times, calling the cops ..."))
