;;; p94-flip-vert.scm

(define (flip-vect painter)
    (transform-painter painter
                       (make-vect 0.0 1.0)
                       (make-vect 1.0 1.0)
                       (make-vect 0.0 0.0)))
