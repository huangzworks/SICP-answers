;;; 33-filtered-accumulate.scm

(define (filtered-accumulate combine null-value term a next b valid?)
    (if (> a b)
        null-value
        (let ((rest-terms (filtered-accumulate combine
                                               null-value
                                               term
                                               (next a)
                                               next
                                               b
                                               valid?)))
            (if (valid? a)
                (combine (term a) rest-terms)
                rest-terms))))
