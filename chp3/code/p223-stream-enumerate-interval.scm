;;; p223-stream-enumerate-interval.scm

(define (stream-enumerate-interval low high)
    (if (> low high)
        '()
        (cons-stream
            low
            (stream-enumerate-interval (+ 1 low) high))))
