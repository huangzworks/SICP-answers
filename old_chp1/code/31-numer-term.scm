;;; 31-numer-term.scm

(define (numer-term i)
    (cond ((= i 1)
            2)
          ((even? i)
            (+ i 2))
          (else
            (+ i 1))))
