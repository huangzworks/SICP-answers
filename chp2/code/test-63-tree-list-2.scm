(load "test-manager/load.scm")
(load "63-tree-list-2.scm")

(define-each-check

    (equal? (tree->list-2 (make-tree 7
                                     (make-tree 3 
                                                (make-tree 1 '() '())
                                                (make-tree 5 '() '()))
                                     (make-tree 9
                                                '()
                                                (make-tree 11 '() '()))))
            (list 1 3 5 7 9 11))

)

(run-registered-tests)
