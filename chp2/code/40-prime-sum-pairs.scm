;;; 40-prime-sum-pairs.scm

(load "40-unique-pairs.scm")
(load "p83-prime-sum.scm")
(load "p83-make-pair-sum.scm")

(define (prime-sum-pairs n)
    (map make-pair-sum
         (filter prime-sum? (unique-pairs n))))
