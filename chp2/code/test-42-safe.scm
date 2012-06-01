(load "test-manager/load.scm")
(load "42-safe.scm")

(define rest-of-queens (list 5 8 2 4))

(define-each-check

    (safe? 5 (cons 7 rest-of-queens))

    ; 行碰撞

    (false? (safe? 5 (cons 2 rest-of-queens)))

    ; 左下方碰撞

    (false? (safe? 5 (cons 8 rest-of-queens)))

    ; 右下方碰撞

    (false? (safe? 5 (cons 6 rest-of-queens)))

)

(run-registered-tests)
