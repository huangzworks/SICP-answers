;;; 28-or-gate.scm

(define (or-gate input-1 input-2 output)
    (define (or-action-procedure)
        (let ((new-value
                (logical-or (get-signal input-1) (get-signal input-2))))
            (after-delay or-gate-delay
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! input-1 or-action-procedure)
    (add-action! input-2 or-action-procedure)
    'ok)

(define (logical-or x y)
    (if (or (= x 1) (= y 1))
        1
        0))
