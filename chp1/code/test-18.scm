(load "test-manager/load.scm")
(load "18.scm")

(define-each-check
    
    (= (multi 2 3)
       (* 2 3))

    (= (multi 4 6)
       (* 4 6))

)

(run-registered-tests)
