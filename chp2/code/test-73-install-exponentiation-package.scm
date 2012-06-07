(load "test-manager/load.scm")

(load "73-install-exponentiation-package.scm")
(load "73-install-product-package.scm")
(load "73-install-sum-package.scm")

(load "73-deriv.scm")

(install-sum-package)
(install-product-package)
(install-exponentiation-package)

(define-each-check

    (equal? (deriv '(** x 0) 'x)
            0)

    (equal? (deriv '(** x 1) 'x)
            0)

    (equal? (deriv '(** x 2) 'x)
            '(* 2 x))

)

(run-registered-tests)
