(load "test-manager/load.scm")
(load "29-mobile-balance")
(load "29-new-selector.scm")
(load "29-new-constructor.scm")

(define-each-check

    (mobile-balance? (make-mobile (make-branch 10 10)
                                 (make-branch 10 10)))

    (false? (mobile-balance? (make-mobile (make-branch 0 0)
                                         (make-branch 10086 10086))))

)

(run-registered-tests)
