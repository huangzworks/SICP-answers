(load "test-manager/load.scm")
(load "47-frame-represent-using-cons.scm")
(load "46-vect-represent.scm")

(define origin (make-vect 0.0 0.0))

(define edge1 (make-vect 0.3 0.3))

(define edge2 (make-vect 0.6 0.6))

(define f (make-frame origin edge1 edge2))

(define-each-check

    (eq? (origin-frame f)
         origin)

    (eq? (edge1-frame f)
         edge1)

    (eq? (edge2-frame f)
         edge2)

)

(run-registered-tests)
