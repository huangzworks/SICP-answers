(load "test-manager/load.scm")
(load "p78-accumulate.scm")

(define-each-check

    (equal? (accumulate cons '() (list 1 2 3))
            (list 1 2 3))

)

(run-registered-tests)
