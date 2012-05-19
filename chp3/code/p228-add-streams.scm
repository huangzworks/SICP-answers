;;; p228-add-streams.scm

(define (add-streams s1 s2)
    (stream-map + s1 s2))
