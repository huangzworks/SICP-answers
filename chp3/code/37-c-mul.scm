;;; 37-c-mul.scm

(define (c* x y)
    (let ((product (make-connector)))
        (multiplier x y product)
        product))
