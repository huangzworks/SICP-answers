(load "test-manager/load.scm")
(load "p83-flatmap.scm")

(define-each-check

    (equal? (flatmap (lambda (lst) 
                         lst)
                     (list (list 1 2 3) (list 4 5 6)))
            (list 1 2 3 4 5 6))

)

(run-registered-tests)
