(load "test-manager/load.scm")
(load "57-deriv.scm")

(define x (make-product 'x 'y))

(define y (make-product 'x 'y 'z))

(define-each-check

    (equal? x
            '(* x y))

    (equal? y
            '(* x y z))

    (equal? (multiplier x)
            'x)

    (equal? (multiplicand x)
            'y)

    (equal? (multiplier y)
            'x)

    (equal? (multiplicand y)
            '(* y z))
)

(define a (make-sum 'x 'y))

(define b (make-sum 'x 'y 'z))

(define-each-check

    (equal? a
            '(+ x y))

    (equal? b 
            '(+ x y z))

    (equal? (addend a)
            'x)

    (equal? (augend a)
            'y)

    (equal? (addend b)
            'x)

    (equal? (augend b)
            '(+ y z))

)

(define-each-check 
    
    (equal? (deriv '(* x y (+ x 3)) 'x)
            '(+ (* x y) (* y (+ x 3))))

)
(run-registered-tests)
