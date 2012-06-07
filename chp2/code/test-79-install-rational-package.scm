(load "test-manager/load.scm")

(load "79-install-rational-package.scm")
(load "79-equ.scm")

(install-rational-package)

(define-each-check

    (equ? (make-rational 1 2)
          (make-rational 1 2))

    (false? (equ? (make-rational 1 2)
                  (make-rational 10086 10086)))

)

(run-registered-tests)
