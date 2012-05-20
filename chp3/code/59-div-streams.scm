;;; 59-div-streams.scm

(define (div-streams s1 s2)
    (stream-map / s1 s2))
