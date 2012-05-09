;;; 10-make-withdraw.scm

(define (make-withdraw initial-amount)
    (let ((balance initial-amount))
        (lambda (amount)
            (if (>= balance amount)
                (begin (set! balance (- balance amount))
                       balance)
                "Insufficient funds"))))
