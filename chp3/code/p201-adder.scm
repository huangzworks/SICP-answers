;;; p201-adder.scm

(define (adder a1 a2 sum)
    (define (process-new-value)
        (cond
            ((and (has-value? a1) (has-value? a2))
                (set-value! sum
                            (+ (get-value a1) (get-value a2))
                            me))
            ((and (has-value? a1) (has-value? sum))
                (set-value! a2 
                            (- (get-value sum) (get-value a1))
                            me))
            ((and (has-value? a2) (has-value? sum))
                (set-value! a1 
                            (- (get-value sum) (get-value a2))
                            me))))
    (define (process-forget-value)
        (forget-value! sum me)
        (forget-value! a1 me)
        (forget-value! a2 me)
        (process-new-value))
    (define (me request)
        (cond
            ((eq? request 'I-have-a-value)
                (process-new-value))
            ((eq? request 'I-lost-my-value)
                (process-forget-value))
            (else
                (error "Unknown request -- ADDER" request))))
    (connect a1 me)
    (connect a2 me)
    (connect sum me)
    me)
