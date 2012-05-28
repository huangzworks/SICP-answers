(load "test-manager/load.scm")
(load "1-make-rate.scm")

(define-each-check

    (equal? (make-rate 1 2)
            (construct-rate 1 2))

    (equal? (make-rate -1 -2)
            (construct-rate 1 2))

    (equal? (make-rate -1 2)
            (construct-rate -1 2))

    (equal? (make-rate 1 -2)
            (construct-rate -1 2))

)

(run-registered-tests)
