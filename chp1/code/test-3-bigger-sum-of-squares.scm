(load "test-manager/load.scm")
(load "3-bigger-sum-of-squares.scm")

(define-each-check
    (= (+ (square 3) (square 6))
       (bigger-sum-of-squares 1 3 6))

    (= (+ (square 4) (square 10))
       (bigger-sum-of-squares 4 2 10))
)

(run-registered-tests)
