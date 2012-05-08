;;; p155-monte-carlo.scm

(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond ((= trials-remaining 0)
                (/ trials-passed trials))
              ((experiment)
                (iter (- trials-remaining 1) (+ trials-passed 1)))
              (else
                (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))
