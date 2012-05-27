;;; p49-deriv.scm

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
           dx)))

(define dx 0.00001)
