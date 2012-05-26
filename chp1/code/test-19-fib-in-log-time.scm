(load "test-manager/load.scm")
(load "19-fib-in-log-time.scm")

(define-each-check

    (= 0
       (fib 0))

    (= 5
       (fib 5))

    (= 21
       (fib 8))

)

(run-registered-tests)
