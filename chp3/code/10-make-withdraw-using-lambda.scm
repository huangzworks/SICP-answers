;;; 10-make-withdraw-using-lambda.scm

(define make-withdraw
    (lambda (initial-amount)
        ((lambda (balance)
            (lambda (amount)
                (if (>= balance amount)
                    (begin (set! balance (- balance amount))
                           balance)
                    "Insufficient funds")))
         initial-amount)))
