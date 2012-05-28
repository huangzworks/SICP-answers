(load "test-manager/load.scm")
(load "2-point-constructor.scm")
(load "2-point-selector.scm")

(define-each-check

    (eq? (x-point (make-point 'x 'y))
         'x)

    (eq? (y-point (make-point 'x 'y))
         'y)

)

(run-registered-tests)
