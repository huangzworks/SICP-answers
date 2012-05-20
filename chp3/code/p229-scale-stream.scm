;;; p229-scale-stream.scm

(define (scale-stream stream factor)
    (stream-map (lambda (x)
                    (* x factor))
                stream))
