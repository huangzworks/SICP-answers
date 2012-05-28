(load "test-manager/load.scm")
(load "2-segment-constructor.scm")
(load "2-segment-selector.scm")

(define-each-check

    (eq? (start-segment (make-segment 'start 'end))
         'start)

    (eq? (end-segment (make-segment 'start 'end))
         'end)

)

(run-registered-tests)
