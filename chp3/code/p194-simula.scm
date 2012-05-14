;;; p194-simula.scm

(load "28-or-gate.scm")
(load "p190-full-adder.scm")
(load "p190-half-adder.scm")
(load "p191-and-gate.scm")
(load "p191-inverter.scm")
(load "p192-wire.scm")
(load "p194-after-delay.scm")
(load "p194-probe.scm")
(load "p194-propagate.scm")
(load "p196-agenda.scm")

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)
