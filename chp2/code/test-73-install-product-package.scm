(load "test-manager/load.scm")

(load "73-install-product-package.scm")
(load "73-install-sum-package.scm")
(load "73-deriv.scm")

(install-sum-package)
(install-product-package)

(define-each-check

    (equal? (deriv '(* x y) 'x)
            'y)

    (equal? (multiplier '(* x y))
            'x)

    (equal? (multiplicand '(* x y))
            'y)

)

(run-registered-tests)
