(load "test-manager/load.scm")
(load "75-make-from-mag-ang.scm")

(define c (make-from-mag-ang 3 5))

(define-each-check

    (= (c 'magnitude)
       3)

    (= (c 'angle)
       5)

)

(run-registered-tests)
