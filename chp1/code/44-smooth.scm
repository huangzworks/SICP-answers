;;; 44-smooth.scm

(define dx 0.00001)

(define (smooth f)
    (lambda (x)
        (/ (+ (f (- x dx))
              (f x)
              (f (+ x dx)))
            3)))
