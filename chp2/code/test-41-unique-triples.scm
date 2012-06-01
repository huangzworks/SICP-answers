(load "test-manager/load.scm")
(load "41-unique-triples.scm")

(define-each-check

    (equal? (unique-triples 5)
            '((3 2 1)
              (4 2 1)
              (4 3 1)
              (4 3 2)
              (5 2 1)
              (5 3 1)
              (5 3 2)
              (5 4 1)
              (5 4 2)
              (5 4 3)))

)

(run-registered-tests)
