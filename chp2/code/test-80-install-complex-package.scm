(load "test-manager/load.scm")

(load "80-complex-driver.scm")

(define-each-check

    (=zero? (make-complex-from-mag-ang 0 0))

    (false? (=zero? (make-complex-from-real-imag 10086 10086)))

    (=zero? (make-complex-from-real-imag 0 0))

    (false? (=zero? (make-complex-from-real-imag 10086 10086)))

)

(run-registered-tests)
