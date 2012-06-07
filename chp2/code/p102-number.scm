;;; p102-number.scm

(define (=number? exp num)
    (and (number? exp)
         (= exp num)))
