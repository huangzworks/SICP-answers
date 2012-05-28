;;; 41-make-triples-equal-to.scm

(load "41-unique-triples.scm")
(load "41-triple-sum-equal.scm")

(define (make-triples-equal-to n s)
    (filter (lambda (t)
                (triple-sum-equal? t s))
            (unique-triples n)))
