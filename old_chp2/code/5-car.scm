;;; 5-car.scm

(define (car z)
    (if (= 0 (remainder z 2))
        (+ 1 (car (/ z 2)))
        0))

