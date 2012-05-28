(load "test-manager/load.scm")
(load "2-point-constructor.scm")
(load "2-point-selector.scm")
(load "2-segment-constructor.scm")
(load "2-segment-selector.scm")
(load "3-rectangle-represent.scm")
(load "3-length-and-width-of-rectangle.scm")

(define length-1 (make-segment (make-point 1 4)
                               (make-point 4 4)))

(define length-2 (make-segment (make-point 1 2)
                               (make-point 4 2)))

(define width-1 (make-segment (make-point 1 2)
                              (make-point 1 4)))

(define width-2 (make-segment (make-point 4 2)
                              (make-point 4 4)))

(define rectangle (make-rectangle length-1 length-2 width-1 width-2))

(define-each-check

    (= (width-of-rectangle rectangle)
       2)

    (= (length-of-rectangle rectangle)
       3)

)

(run-registered-tests)
