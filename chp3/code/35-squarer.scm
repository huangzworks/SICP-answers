;;; 35-squarer.scm

(load "p205-constraint.scm")

(define (squarer a b)
    (define (process-new-value)
        (if (has-value? b)
            (if (< (get-value b) 0)
                (error "square less than 0 -- SQUARER" (get-value b))
                (set-value! a
                            (sqrt (get-value b))
                            me))
            (if (has-value? a)
                (set-value! b
                            (square (get-value a))
                            me)
                (error "Neither a nor b has value"))))
    (define (process-forget-value)
        (forget-value! a me)
        (forget-value! b me))
    (define (me request)
        (cond
            ((eq? request 'I-have-a-value)
                (process-new-value))
            ((eq? request 'I-lost-my-value)
                (process-forget-value))
            (else
                (error "Unknown request -- MULTIPLIER" request))))
    (connect a me)
    (connect b me)
    me)
