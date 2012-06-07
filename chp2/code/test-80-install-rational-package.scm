(load "test-manager/load.scm")

(load "80-install-rational-package.scm")
(load "80-zero.scm")

(install-rational-package)

(define-each-check

    (=zero? (make-rational 0 1))

    (false? (=zero? (make-rational 10086 10086)))

)

(run-registered-tests)
