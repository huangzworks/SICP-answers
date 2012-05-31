(load "test-manager/load.scm")
(load "36-accumulate-n.scm")

(define-each-check

    (equal? (accumulate-n + 0 (list (list 1 2 3)
                                    (list 4 5 6)
                                    (list 7 8 9)
                                    (list 10 11 12)))
            (list 22 26 30))

)

(run-registered-tests)
