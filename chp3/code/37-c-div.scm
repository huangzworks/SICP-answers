;;; 37-c-div.scm

(define (c/ p q)
    (let ((r (make-connector)))
        (multiplier q r p)
        r))
