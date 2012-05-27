(load "test-manager/load.scm")
(load "p48-average-damp.scm")

(define-each-check

    (= 2
       ((average-damp (lambda (x) x))
        2))

)

(run-registered-tests)
