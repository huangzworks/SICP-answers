;;; 1-make-rate.scm

(define (make-rate n d)
    (cond ((and (positive? n) (positive? d))
            (construct-rate n d))
          ((and (negative? n) (negative? d))
            (construct-rate (abs n) (abs d)))
          (else
            (construct-rate (- (abs n)) (abs d)))))

(define (construct-rate n d)
    (cons n d))
