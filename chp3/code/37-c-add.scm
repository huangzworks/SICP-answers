;;; 37-c-add.scm

(define (c+ x y)
    (let ((sum (make-connector)))
        (adder x y sum)
        sum))
