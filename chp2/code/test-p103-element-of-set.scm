(load "test-manager/load.scm")
(load "p103-element-of-set.scm")

(define-each-check

    (element-of-set? 'a '(a))

    (element-of-set? 'a '(x y b a z))

    (false? (element-of-set? 'a '(x y z)))

    (false? (element-of-set? 'a '()))

)

(run-registered-tests)
