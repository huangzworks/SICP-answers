;;; p202-multiplier.scm

(define (multiplier m1 m2 product)
    (define (process-new-value)
        (cond
            ((or (and (has-value? m1) (= 0 (get-value m1)))
                 (and (has-value? m2) (= 0 (get-value m2))))
                (set-value! product 0 me))
            ((and (has-value? m1) (has-value? m2))
                (set-value! product
                            (* (get-value m1) (get-value m2))
                            me))
            ((and (has-value? product) (has-value? m1))
                (set-value! m2
                            (/ (get-value product) (get-value m1))
                            me))
            ((and (has-value? product) (has-value? m2))
                (set-value! m1
                            (/ (get-value product) (get-value m2))
                            me))))
    (define (process-forget-value)
        (forget-value! product me)
        (forget-value! m1 me)
        (forget-value! m2 me)
        (process-new-value))
    (define (me request)
        (cond
            ((eq? request 'I-have-a-value)
                (process-new-value))
            ((eq? request 'I-lost-my-value)
                (process-forget-value))
            (else
                (error "Unknown request -- MULTIPLIER" request))))
    (connect m1 me)
    (connect m2 me)
    (connect product me)
    me)
