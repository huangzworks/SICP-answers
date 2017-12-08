;;; 33-iter-filtered-accumulate.scm

(define (filtered-accumulate combine null-value term a next b valid?)
    (define (iter i result)
        (cond ((> i b)
                result)
              ((valid? (term i))
                (iter (next i) (combine (term i) result)))
              (else 
                (iter (next i) result))))
    (iter a null-value))
