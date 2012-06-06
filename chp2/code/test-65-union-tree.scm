(load "test-manager/load.scm")
(load "65-union-tree.scm")

(define-each-check

    (equal? (tree->list-2 (union-tree (list->tree '(1 2 3 4 5)) 
                                      (list->tree '(1 3 5 7 9))))
            '(1 2 3 4 5 7 9))

)

(run-registered-tests)
