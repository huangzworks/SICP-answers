;;; 35-count-leaves-using-fringe.scm

(load "28-fringe.scm")
(load "p78-accumulate.scm")

(define (count-leaves tree)
    (accumulate (lambda (current-leave remained-leaves-count)
                    (+ 1 remained-leaves-count))
                0
                (fringe tree)))
