(load "test-manager/load.scm")

(load "73-deriv.scm")
(load "73-install-sum-package.scm")

(install-sum-package)

(define-each-check

    (equal? (deriv '(+ x 3) 'x)
            1)

    (equal? (addend '(+ x 3))
            'x)

    (equal? (augend '(+ x 3))
            3)

)

(run-registered-tests)
