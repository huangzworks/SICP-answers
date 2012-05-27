;;; 38-e.scm

(load "37-iter-cont-frac.scm")

(define (e k)

    (define (N i)
        1)

    (define (D i)
        (if (= 0 (remainder (+ i 1) 3))
            (* 2 (/ (+ i 1) 3))
            1))

    (+ 2.0 
       (cont-frac N D k)))
