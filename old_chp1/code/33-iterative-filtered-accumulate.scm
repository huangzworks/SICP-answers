;;; 33-iterative-filtered-accumulate.scm

(define (filtered-accumulate combine null-value term a next b valid?)
    (define (iter a result)
        (cond ((> a b)
                result)
              ((valid? a)
                (iter (next a) (combine (term a) result)))
              (else 
                (iter (next a) result))))
    (iter a null-value))
