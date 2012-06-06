;;; 65-union-tree.scm

(load "62-union-set.scm")
(load "63-tree-list-2.scm")
(load "64-list-tree.scm")

(define (union-tree tree another)
    (list->tree
        (union-set (tree->list-2 tree)
                   (tree->list-2 another))))
