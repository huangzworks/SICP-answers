;;; 5-estimate-integral.scm

(load "p155-monte-carlo.scm")
(load "5-random-in-range.scm")

(define (estimate-integral p? x1 x2 y1 y2 trials)
    (* 4
       (monte-carlo trials
                    (lambda ()
                        (p? (random-in-range x1 x2)
                            (random-in-range y1 y2))))))

(define (get-pi trials)
    (exact->inexact
        (estimate-integral (lambda (x y)
                               (< (+ (square x)
                                     (square y))
                                1.0))
                           -1.0
                           1.0
                           -1.0
                           1.0
                           trials)))
