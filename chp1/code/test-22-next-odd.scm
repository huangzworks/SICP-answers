(load "test-manager/load.scm")
(load "22-next-odd.scm")

(define-each-check

    (= 3
       (next-odd 2))

    (= 5
       (next-odd 3))

)

(run-registered-tests)
