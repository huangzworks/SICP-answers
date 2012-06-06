(load "test-manager/load.scm")
(load "64-list-tree.scm")

(define-each-check

    (equal?  (list->tree '(1 3 5 7 9 11))
             '(5 (1 () (3 () ())) (9 (7 () ()) (11 () ()))))

)

(run-registered-tests)
