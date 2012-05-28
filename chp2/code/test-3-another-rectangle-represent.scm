(load "test-manager/load.scm")
(load "2-point-constructor.scm")
(load "2-segment-constructor.scm")
(load "3-another-rectangle-represent.scm")

(define l (make-segment (make-point 1 2)
                        (make-point 4 2)))

(define w (make-segment (make-point 1 2)
                        (make-point 1 4)))

(define r (make-rectangle l w))

(define-each-check

    (eq? (length-rectangle r)
         l)

    (eq? (width-rectangle r)
         w)

)

(run-registered-tests)
