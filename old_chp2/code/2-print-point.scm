;;; 2-print-point.scm

(load "2-point-selector.scm")

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")"))
