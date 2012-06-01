;;; 41-triple-sum-equal-to.scm

(define (triple-sum-equal-to? sum triple)
    (= sum
       (+ (car triple)
          (cadr triple)
          (caddr triple))))
