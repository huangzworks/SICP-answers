;;; p106-tree.scm

(define (make-tree entry left right)
    (list entry left right))

(define (entry tree)
    (car tree))

(define (left-branch tree)
    (cadr tree))

(define (right-branch tree)
    (caddr tree))
