;;; 40-cubic.scm

(load "p37-cube.scm")

(define (cubic a b c)
    (lambda (x)
        (+ (cube x)
           (* a (square x))
           (* b x)
           c)))
