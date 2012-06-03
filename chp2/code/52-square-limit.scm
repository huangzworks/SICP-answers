;;; 52-square-limit.scm

(define (square-limit painter n)
    (let ((combine4 (square-of-four identity flip-horiz)
                                    flip-vect rotate180))
        (combine4 (corner-split painter n))))
