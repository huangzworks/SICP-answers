(load "test-manager/load.scm")
(load "27-carmichael-test.scm")

(define-each-check

    (carmichael-test 561)

    (carmichael-test 2821)

    (carmichael-test 6601)

)

(run-registered-tests)
