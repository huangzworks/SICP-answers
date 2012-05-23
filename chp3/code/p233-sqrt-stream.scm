;;; p233-sqrt-stream.scm

(load "p232-sqrt-improve.scm")

(define (sqrt-stream x)
    (define guesses
        (cons-stream 1.0
                     (stream-map (lambda (guess)
                                     (sqrt-improve guess x))
                                 guesses)))
    guesses)
