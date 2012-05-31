;;; 39-reverse-using-fold-left.scm

(define (reverse sequence)
    (fold-left (lambda (x y)
                   (cons y x))
               '()
               sequence))
