;;; 64-stream-limit.scm

(define (stream-limit stream tolerance)
    (let ((ref-n (stream-car stream))
          (ref-n+1 (stream-car (stream-cdr stream))))
        (if (close-enough? ref-n ref-n+1 tolerance)
            ref-n+1
            (stream-limit (stream-cdr stream) tolerance))))

(define (close-enough? x y tolerance)
    (< (abs (- x y))
       tolerance))
