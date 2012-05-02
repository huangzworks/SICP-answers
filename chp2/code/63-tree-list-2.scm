;;; 63-tree-list-2.scm

(load "p106-tree.scm")

(define (tree->list-2 tree)
    (define (copy-to-list tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list (left-branch tree)
                          (cons (entry tree)
                                (copy-to-list (right-branch tree)
                                              result-list)))))
    (copy-to-list tree '()))
