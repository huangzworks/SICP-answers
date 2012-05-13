;;; 27-memo-fib.scm

(load "p184-table.scm")
(load "27-memoize.scm")

(define memo-fib
    (memoize (lambda (n)
                (cond ((= n 0) 
                        0)
                      ((= n 1)
                        1)
                      (else
                        (+ (memo-fib (- n 1))
                           (memo-fib (- n 2))))))))
