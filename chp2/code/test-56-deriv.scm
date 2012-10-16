(load "test-manager/load.scm")
(load "56-deriv.scm")

(define-each-check

    (equal? (deriv '(** x 0) 'x)
            0)

    (equal? (deriv '(** x 1) 'x)
            1)

    (equal? (deriv '(** x 2) 'x)
            '(* 2 x))

    (equal? (deriv '(** x 3) 'x)
            '(* 3 (** x 2)))

)

(run-registered-tests)
