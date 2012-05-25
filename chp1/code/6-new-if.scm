;;; 6-new-if.scm

(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))
