;;; 40-unique-pairs.scm

(load "p78-enumerate-interval.scm")
(load "p83-flatmap.scm")

(define (unique-pairs n)
    (flatmap (lambda (i)
                 (map (lambda (j) (list i j))
                      (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))
