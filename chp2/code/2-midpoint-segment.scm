;;; 2-midpoint-segment.scm

(load "2-segment-selector.scm")
(load "2-point-constructor.scm")
(load "2-point-selector.scm")

(define (midpoint-segment seg)
    (let ((start (start-segment seg))
          (end (end-segment seg)))
        (make-point (average (x-point start)
                             (x-point end))
                    (average (y-point start)
                             (y-point end)))))

(define (average x y)
    (/ (+ x y)
       2.0))
