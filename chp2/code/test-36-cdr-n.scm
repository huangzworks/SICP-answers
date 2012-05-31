(load "test-manager/load.scm")
(load "36-cdr-n.scm")

(define-each-check

    (equal? (cdr-n (list (list 1 2 3)
                         (list 4 5 6)
                         (list 7 8 9)))
            (list (list 2 3)
                  (list 5 6)
                  (list 8 9)))

)

(run-registered-tests)
