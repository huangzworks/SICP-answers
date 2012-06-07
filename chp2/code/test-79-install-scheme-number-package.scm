(load "test-manager/load.scm")

(load "79-install-scheme-number-package.scm")
(load "79-equ.scm")

(install-scheme-number-package)

(define-each-check

    (equ? (make-scheme-number 10)
          (make-scheme-number 10))

    (false?  (equ? (make-scheme-number 10)
                   (make-scheme-number 1008611)))

)

(run-registered-tests)
