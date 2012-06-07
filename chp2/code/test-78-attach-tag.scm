(load "test-manager/load.scm")

(load "78-attach-tag.scm")

(define-each-check

    (equal? (attach-tag 'scheme-number 10)
            10)

    (equal? (attach-tag 'complex (cons 1 2))
            (cons 'complex (cons 1 2)))

)

(run-registered-tests)
