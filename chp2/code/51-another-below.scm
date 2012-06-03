;;; 51-another-below.scm

(define (below painter1 painter2)
    (lambda (frame)
        ((flip-horiz
            (rotate90
                (beside
                    (rotate270
                        (flip-horiz painter1))
                    (rotate270
                        (flip-horiz painter2)))))
         frame)))
