(load "test-manager/load.scm")
(load "29-mobile-represent.scm")
(load "29-mobile-blance.scm")

(define-each-check

    (mobile-blance? (make-mobile (make-branch 10 10)
                                 (make-branch 10 10)))

    (false? (mobile-blance? (make-mobile (make-mobile 0 0)
                                         (make-mobile 10086 10086))))

    ; 递归活动体
    (mobile-blance? (make-mobile (make-branch 10 (make-mobile (make-branch 10 10)
                                                              (make-branch 10 10)))
                                 (make-branch 10 (make-branch (make-branch 10 10)
                                                              (make-branch 10 10)))))

)

(run-registered-tests)
