;;; 3-another-length-and-width-of-rectangle.scm

(load "2-segment-selector.scm")
(load "2-point-selector.scm")
(load "3-another-rectangle-represent.scm")

(define (length-of-rectangle r)
    (let ((length (length-rectangle r)))
        (let ((start (start-segment length))
              (end (end-segment length)))
            (- (x-point end)
               (x-point start)))))

(define (width-of-rectangle r)
    (let ((width (width-rectangle r)))
        (let ((start (start-segment width))
              (end (end-segment width)))
            (- (y-point end)
               (y-point start)))))
