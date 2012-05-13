;;; 27-another-memo-fib.scm

(load "p184-table.scm")
(load "27-memoize.scm")

(define (fib n)
    (cond ((= n 0)
            0)
          ((= n 1)
            1)
          (else
            (+ (fib (- n 1))
               (fib (- n 2))))))

(define memo-fib (memoize fib))
