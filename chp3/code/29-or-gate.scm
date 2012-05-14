;;; 29-or-gate.scm

(load "p191-and-gate.scm")
(load "p191-inverter.scm")

(define (or-gate a1 a2 output)
    (let ((not-a1 (make-wire))
          (not-a2 (make-wire))
          (and-not-a1-not-a2 (make-wire)))
        (inverter a1 not-a1)                    ; (not a1)
        (inverter a2 not-a2)                    ; (not a2)
        (and-gate a1 a2 and-not-a1-not-a2)      ; (and (not a1) (not a2))
        (inverter and-not-a1-not-a2 output))    ; (not (and (not a1) (not a2)))
    'ok)
