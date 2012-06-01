;;; 41-triple-sum-equal-to-using-fold.scm

(define (triple-sum-equal-to? sum triple)
    (= sum
       (fold-right + 0 triple)))
