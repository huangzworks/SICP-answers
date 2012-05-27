(load "test-manager/load.scm")
(load "42-compose.scm")

(define-each-check

    (= ((compose square square) 2)
       (square (square 2)))

)

(run-registered-tests)
