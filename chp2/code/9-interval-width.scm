;;; 9-interval-width.scm

(load "8-sub-interval.scm")
(load "7-add-interval.scm")
(load "7-mul-interval.scm")
(load "7-div-interval.scm")

(define (width x)
  (/ (- (upper-bound x) (lower-bound x)) 2))
