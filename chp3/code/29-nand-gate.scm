;;; 29-nand-gate.scm

(define nand-gate-delay 3)

(define (nand-gate input-1 input-2 output)
    (define (nand-action-procedure)
        (let ((new-value
                (logical-nand (get-signal input-1) (get-signal input-2))))
            (after-delay nand-gate-delay
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! input-1 nand-action-procedure)
    (add-action! input-2 nand-action-procedure)
    'ok)

(define (logical-nand x y)
    (if (and (= x 1) (= y 1))
        0
        1))
