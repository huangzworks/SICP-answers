(load "test-manager/load.scm")
(load "27-tree-reverse.scm")

(define binary-tree (list (list 1 2) (list 3 4)))

(define three-branch-tree (list (list 1 2) (list 3 4) (list 5 6)))

(define-each-check

    (equal? (tree-reverse '())
            '())

    (equal? (tree-reverse binary-tree)
            (list (list 4 3) (list 2 1)))

    (equal? (tree-reverse three-branch-tree)
            (list (list 6 5) (list 4 3) (list 2 1)))

)

(run-registered-tests)
