(load "test-manager/load.scm")

(load "78-type-tag.scm")

(define-each-check

    (equal? (type-tag 10)
            'scheme-number)

    (equal? (type-tag (cons 'complex (cons 1 2)))
            'complex)

)

(run-registered-tests)
