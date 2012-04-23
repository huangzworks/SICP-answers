;;; 41-triple-sum-equal.scm

(define (triple-sum-equal? triple s)
    (= s
       (+ (car triple)
          (cadr triple)
          (caddr triple))))
