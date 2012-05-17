;;; 37-c-sub.scm

(define (c-sub x y)
    (let ((diff (make-connector)))
        (adder y diff x)
        diff))
