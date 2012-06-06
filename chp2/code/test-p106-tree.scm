(load "test-manager/load.scm")
(load "p106-tree.scm")

(define t (make-tree 1 2 3))

(define-each-check

    (equal? t 
            (list 1 2 3))

    (equal? (entry t)
            1)

    (equal? (left-branch t)
            2)

    (equal? (right-branch t)
            3)

)

(run-registered-tests)
