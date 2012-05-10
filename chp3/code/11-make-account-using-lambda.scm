;;; 11-make-account-using-lambda.scm

(define make-account

    (lambda (balance)

        (define withdraw
            (lambda (amount)
                (if (>= balance amount)
                    (begin (set! balance (- balance amount))
                           balance)
                    "Insufficient funds")))

        (define deposit 
            (lambda (amount)
                (set! balance (+ balance amount))))

        (define dispatch
            (lambda (m)
                (cond ((eq? m 'withdraw)
                        withdraw)
                      ((eq? m 'deposit)
                        deposit)
                      (else
                        (error "Unknown request -- MAKE-ACCOUNT" m)))))

        dispatch))
