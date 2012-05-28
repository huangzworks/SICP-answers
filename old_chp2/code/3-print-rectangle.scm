;;; 3-print-rectangle.scm

(load "2-segment-selector.scm")
(load "2-print-point.scm")

(define (print-rectangle r)
    (let ((l1 (length-1-rectangle r))
          (l2 (length-2-rectangle r))
          (w1 (width-1-rectangle r))
          (w2 (width-2-rectangle r)))

        (newline)
        (display "Length 1:")
        (print-point (start-segment l1))
        (print-point (end-segment l1))

        (newline)
        (display "Length 2:")
        (print-point (start-segment l2))
        (print-point (end-segment l2))

        (newline)
        (display "Width 1:")
        (print-point (start-segment w1))
        (print-point (end-segment w1))

        (newline)
        (display "Width 2:")
        (print-point (start-segment w2))
        (print-point (end-segment w2))))
