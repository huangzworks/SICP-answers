(load "test-manager/load.scm")

(load "p133-coercion.scm")

(put-coercion 'number 'square-number square)

(define-each-check

    (equal? (get-coercion 'number 'square-number)
            square)

    (false? (get-coercion 'number 'not-exists-type))

)

(run-registered-tests)
