(load "test-manager/load.scm")
(load "48-segment-represent.scm")
(load "46-vect-represent.scm")

(define start (make-vect 0.3 0.3))

(define end (make-vect 0.6 0.6))

(define seg (make-segment start end))

(define-each-check

    (eq? (start-segment seg)
         start)

    (eq? (end-segment seg)
         end)

)

(run-registered-tests)
