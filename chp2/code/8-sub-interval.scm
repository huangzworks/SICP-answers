;;; 8-sub-interval.scm

(load "7-make-interval.scm")

(define (sub-interval x y)
  (make-interval (- (lower-bound x) 
                    (lower-bound y))
                 (- (upper-bound x) 
                    (upper-bound y))))


