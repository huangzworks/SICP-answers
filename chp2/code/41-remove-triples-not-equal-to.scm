;;; 41-remove-triples-not-equal-to.scm

(load "41-triple-sum-equal-to.scm")

(define (remove-triples-not-equal-to sum triple)
    (filter (lambda (current-triple)
                (triple-sum-equal-to? sum current-triple))
            triple))
