(load "test-manager/load.scm")
(load "33-primes-sum.scm")

(define-each-check

    (= (primes-sum 1 10)
       (+ 1 2 3 5 7))

)

(run-registered-tests)
