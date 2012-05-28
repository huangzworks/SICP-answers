(load "test-manager/load.scm")
(load "2-point-constructor.scm")
(load "2-point-selector.scm")
(load "2-segment-constructor.scm")
(load "2-segment-selector.scm")
(load "2-midpoint-segment.scm")

(define-each-check

    (equal? (midpoint-segment (make-segment (make-point 1 3)
                                            (make-point 4 3)))

            (make-point 2.5 3.0))

)

(run-registered-tests)
