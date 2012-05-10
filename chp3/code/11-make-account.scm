;;; 11-make-account.scm

(define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount)))
    (define (dispatch m)
        (cond ((eq? m 'withdraw) withdraw) 
              ((eq? m 'deposit) deposit)
              (else
                (error "Unknown request -- MAKE-ACCOUNT" m))))
    dispatch)
