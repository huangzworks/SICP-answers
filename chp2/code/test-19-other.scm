(load "test-manager/load.scm")
(load "19-other.scm")
(load "19-cc.scm")

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define-each-check

    (= (cc 100 us-coins)
       292)

    (= (cc 100 uk-coins)
       104561)

    (= (cc 100 us-coins)
       (cc 100 (reverse us-coins)))

)

(run-registered-tests)
