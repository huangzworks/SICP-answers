;;; 29-or-gate.scm

(load "p191-and-gate.scm")
(load "p191-inverter.scm")

(define (or-gate input-1 input-2 output)
    (let ((invert-1 (make-wire))
          (invert-2 (make-wire))
          (and-invert-1-invert-2 (make-wire)))
        (inverter input-1 invert-1)
        (inverter input-2 invert-2)
        (and-gate invert-1 invert-2 and-invert-1-invert-2)
        (inverter and-invert-1-invert-2 output))
    'ok)
