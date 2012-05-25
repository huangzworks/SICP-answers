(load "test-manager/load.scm")
(load "p8-sum-of-squares.scm")

(define-each-check
    (= (sum-of-squares 2 3)
       (+ (square 2)
          (square 3)))

    (= (sum-of-squares 5 7)
       (+ (square 5)
          (square 7)))
)

(run-registered-tests)
