;;; 1-make-accumulator.scm

(define (make-accumulator value)
    (lambda (add-value)
        (set! value (+ value add-value))
        value))
