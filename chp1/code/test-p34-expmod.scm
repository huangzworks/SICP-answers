(load "test-manager/load.scm")
(load "p34-expmod.scm")

(define-each-check 

    (= 1
       (expmod 7 1 3))

    (= 2
       (expmod 8 1 3))

)

(run-registered-tests)
