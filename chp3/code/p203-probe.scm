;;; p203-probe.scm

(define (probe name connector)
    (define (print-probe value)
        (newline)
        (display "Probe: ")
        (display name)
        (display " = ")
        (display value))
    (define (process-new-value)
        (print-probe (get-value connector)))
    (define (process-forget-value)
        (print-probe "?"))
    (define (me request)
        (cond
            ((eq? request 'I-have-a-value)
                (process-new-value))
            ((eq? request 'I-lost-my-value)
                (process-forget-value))
            (else
                (error "Unknown request -- PROBE" request))))
    (connect connector me)
    me)
