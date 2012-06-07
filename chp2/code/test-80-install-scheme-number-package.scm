(load "test-manager/load.scm")

(load "80-install-scheme-number-package.scm")
(load "80-zero.scm")

(install-scheme-number-package)

(define-each-check

    (=zero? (make-scheme-number 0))

    (false? (=zero? (make-scheme-number 10086)))

)

(run-registered-tests)
