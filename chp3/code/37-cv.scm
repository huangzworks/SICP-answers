;;; 37-cv.scm

(define (cv value)
    (let ((connector (make-connector)))
        (constant value connector)
        connector))
