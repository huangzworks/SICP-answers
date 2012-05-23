;;; 63-sqrt-stream.scm

(load "p232-sqrt-improve.scm")

(define (sqrt-stream x)
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                                 (sqrt-improve guess x))
                             (sqrt-stream x))))
