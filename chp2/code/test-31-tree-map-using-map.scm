(load "test-manager/load.scm")
(load "31-tree-map-using-map.scm")

(define-each-check

    (equal? (tree-map square (list (list 1 2) (list 3 4)))
            (list (list (square 1) (square 2))
                  (list (square 3) (square 4))))

)

(run-registered-tests)
