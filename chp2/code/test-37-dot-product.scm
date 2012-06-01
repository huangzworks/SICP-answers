(load "test-manager/load.scm")
(load "37-dot-product.scm")

(define-each-check

    (equal?  (dot-product (list 1 2 3 4)
                          (list 1 2 3 4))
             (fold-right + 0 (map * (list 1 2 3 4)
                                    (list 1 2 3 4))))

)

(run-registered-tests)
