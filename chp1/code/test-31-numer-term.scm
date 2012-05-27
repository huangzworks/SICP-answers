(load "test-manager/load.scm")
(load "31-numer-term.scm")

(define-each-check

    (= 2
       (numer-term 1))

    (= 4
       (numer-term 2))

    (= 4
       (numer-term 3))

    (= 6
       (numer-term 4))

)

(run-registered-tests)
