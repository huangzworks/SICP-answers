(load "test-manager/load.scm")
(load "29-mobile-represent.scm")

(define left (make-branch 10 25))
(define right (make-branch 5 20))

(define mobile (make-mobile left right))

(define-each-check
    
    (eq? (left-branch mobile)
         left)

    (eq? (right-branch mobile)
         right)

    (= (branch-length (right-branch mobile))
       (branch-length right))

    (= (branch-structure (right-branch mobile))
       (branch-structure right))

)

(run-registered-tests)
