(load "test-manager/load.scm")
(load "29-mobile-represent.scm")
(load "29-total-weight.scm")

(define mobile (make-mobile (make-branch 10 20)             ; 总重 45
                            (make-branch 10 25)))

(define another-mobile (make-mobile (make-branch 10 mobile) ; 总重 65
                                    (make-branch 10 20)))

(define-each-check

    (= (total-weight mobile)
       45)

    (= (total-weight another-mobile)
       65)

)

(run-registered-tests)
