;;; 48-make-account.scm

(load "parallel.scm")   ; 载入 make-serializer

; 修改自书本 214 页的 make-account-and-serializer
; 带注释的行是新添加的

(define (make-account balance)
    
    (let ((id (generate-account-id)))                       ; +

        (define (withdraw amount)
            (if (>= balance amount)
                (begin (set! balance (- balance amount))
                       balance)
                "Insufficient funds"))

        (define (deposit amount)
            (set! balance (+ balance amount))
            balance)

        (let ((balance-serializer (make-serializer)))
            (define (dispatch m)
                (cond
                    ((eq? m 'withdraw)
                        withdraw)
                    ((eq? m 'deposit)
                        deposit)
                    ((eq? m 'balance)
                        balance)
                    ((eq? m 'serializer)
                        balance-serializer)
                    ((eq? m 'id)                            ; +
                        id)                                 ; +
                    (else
                        (error "Unknown request -- MAKE-ACCOUNT" m))))

            dispatch)))

(define (counter)
    (let ((i 0))
        (lambda ()
            (set! i (+ 1 i))
            i)))

(define generate-account-id (counter))
