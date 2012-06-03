;;; 52-corner-split.scm

(define (corner-split painter n)
    (if (= n 0)
        painter
        (let ((up (up-split painter (- n 1)))
              (right (right-split painter (- n 1)))
              (corner (corner-split painter (- n 1))))
            (beside (below painter up)
                    (below right corner)))))
