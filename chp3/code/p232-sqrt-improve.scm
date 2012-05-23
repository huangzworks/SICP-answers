;;; p232-sqrt-improve.scm

(define (sqrt-improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y)
       2.0))
