;;; 39-reverse-using-fold-right.scm

(define (reverse sequence)
    (fold-right (lambda (x y)
                    (append y (list x)))
                '()
                sequence))
