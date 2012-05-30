(load "test-manager/load.scm")
(load "29-mobile-represent.scm")
(load "29-branch-torque.scm")

(define branch (make-branch 10 20))

(define-each-check

    (= (branch-torque branch)
       200)

)

(run-registered-tests)
