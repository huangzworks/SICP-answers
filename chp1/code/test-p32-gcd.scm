(load "test-manager/load.scm")
(load "p32-gcd.scm")

(define-each-check

    (= 2 (gcd 2 4))

    (= 1
       (gcd 3 7))

)

(run-registered-tests)
