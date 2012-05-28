;;; 3-length-and-width-of-rectangle.scm

(load "3-rectangle-represent.scm")
(load "2-segment-selector.scm")

(define (length-of-rectangle r)
    (let ((length (length-1-rectangle r)))
        (let ((start (start-segment length))
              (end (end-segment length)))
            (- (x-point end)
               (x-point start)))))

(define (width-of-rectangle r)
    (let ((width (width-1-rectangle r)))
        (let ((start (start-segment width))
              (end (end-segment width)))
            (- (y-point end)
               (y-point start)))))
