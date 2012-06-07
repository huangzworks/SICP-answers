(load "test-manager/load.scm")

(load "79-complex-driver.scm")

(install-complex-package)

(define-each-check

    (equ? (make-complex-from-mag-ang 1 2)
          (make-complex-from-mag-ang 1 2))

    (false? (equ? (make-complex-from-mag-ang 1 2)
                  (make-complex-from-mag-ang 10086 10086)))

    (equ? (make-complex-from-real-imag 1 2)
          (make-complex-from-real-imag 1 2))

    (false? (equ? (make-complex-from-real-imag 1 2)
                  (make-complex-from-real-imag 10086 10086)))

)

(run-registered-tests)
