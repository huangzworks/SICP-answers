;;; 29-another-or-gate.scm

(load "29-nand-gate.scm")

(define (or-gate input-1 input-2 output)
    (let ((invert-1 (make-wire))
          (invert-2 (make-wire)))
        (inverter input-1 invert-1)
        (inverter input-1 invert-2)
        (nand-gate invert-1 invert-2 output)))
