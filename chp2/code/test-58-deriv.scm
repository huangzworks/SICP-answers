(load "test-manager/load.scm")
(load "58-deriv.scm")

(define s (make-sum 'x 'y))

(define-each-check

    (sum? s)

    (equal? s
            '(x + y))

    (equal? (addend s)
            'x)

    (equal? (augend s)
            'y)

)

(define p (make-product 'x 'y))

(define-each-check

    (product? p)

    (equal? p
            '(x * y))

    (equal? (multiplier p)
            'x)

    (equal? (multiplicand p)
            'y)

)

(run-registered-tests)
