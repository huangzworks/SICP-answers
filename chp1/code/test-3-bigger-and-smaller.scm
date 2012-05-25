(load "test-manager/load.scm")
(load "3-bigger-and-smaller.scm")

(define-test (test-bigger)
    (check (= 3 
              (bigger 2 3)))
    (check (= 6
              (bigger 6 3)))
)

(define-test (test-smaller)
    (check (= 1
              (smaller 1 3)))
    (check (= 7
              (smaller 7 10)))
)

(run-registered-tests)
