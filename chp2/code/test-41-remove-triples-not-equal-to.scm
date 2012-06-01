(load "test-manager/load.scm")
(load "41-unique-triples.scm")
(load "41-remove-triples-not-equal-to.scm")

(define-each-check

    (equal? (remove-triples-not-equal-to 5 (unique-triples 6))
            '())

    (equal? (remove-triples-not-equal-to 6 (unique-triples 6))
            '((3 2 1)))

)

(run-registered-tests)
