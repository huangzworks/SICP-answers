(load "test-manager/load.scm")

(load "78-contents.scm")

(define-each-check

    (equal? (contents 10)
            10)

    (equal? (contents (cons 'complex (cons 1 2)))
            (cons 1 2))

)

(run-registered-tests)
