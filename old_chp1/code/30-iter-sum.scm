;;; 30-iter-sum.scm

(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a)
                  (+ (term a) result))))
    (iter a 0))
