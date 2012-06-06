;;; 65-intersection-tree.scm

(load "63-tree-list-2.scm")
(load "64-list-tree.scm")
(load "p105-intersection-set.scm")

(define (intersection-tree tree another)
    (list->tree
        (intersection-set (tree->list-2 tree)
                          (tree->list-2 another))))
