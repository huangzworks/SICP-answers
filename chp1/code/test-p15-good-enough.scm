(load "test-manager/load.scm")
(load "p15-good-enough.scm")

(define-each-check
    
    (false? (good-enough? 2 9))

    (good-enough? 3 9)

)

(run-registered-tests)
