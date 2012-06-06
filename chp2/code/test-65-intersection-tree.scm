(load "test-manager/load.scm")
(load "65-intersection-tree.scm")

(define-each-check

    (equal?
        (tree->list-2 (intersection-tree (list->tree '(1 3 5 7 9))
                                         (list->tree '(1 2 3 4 5))))
        '(1 3 5))

)

(run-registered-tests)
