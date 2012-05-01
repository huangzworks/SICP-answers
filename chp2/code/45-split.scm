;;; 45-split.scm

(define (split big-combiner small-combiner)
    (lambda (painter n)
        (if (= n 0)
            painter
            (let ((smaller ((split big-combiner small-combiner) painter (- n 1))))
                (big-combiner painter
                              (small-combiner smaller smaller))))))
