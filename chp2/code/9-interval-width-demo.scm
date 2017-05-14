;;; 9-interval-width.scm

(load "7-add-interval.scm")
(load "7-mul-interval.scm")
(load "7-div-interval.scm")
(load "8-sub-interval.scm")
(load "9-interval-width.scm")

(define a (make-interval 90 100))
(width a)
; 5

(define b (make-interval 70 80))
(width b)
; 5

(width (add-interval a b))
; 10 = 5 + 5
(width (sub-interval a b))
; 0 = 5 - 5

(width (mul-interval a b))
; 850 != 5 * 5

(width (div-interval a b))
; 0.1517857142857143 != 5 / 5

