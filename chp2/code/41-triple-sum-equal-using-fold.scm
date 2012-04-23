;;; 41-triple-sum-equal-using-fold.scm

(define (triple-sum-equal? triple s)
    (= s (fold-right + 0 triple)))
