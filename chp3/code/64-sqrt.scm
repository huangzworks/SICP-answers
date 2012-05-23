;;; 64-sqrt.scm

(load "64-stream-limit.scm")
(load "p233-sqrt-stream.scm")

(define (sqrt x tolerance)
    (stream-limit (sqrt-stream x) tolerance))
