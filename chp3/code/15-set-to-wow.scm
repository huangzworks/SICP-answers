;;; 15-set-to-wow.scm

(define (set-to-wow! x)
    (set-car! (car x) 'wow!)
    x)
