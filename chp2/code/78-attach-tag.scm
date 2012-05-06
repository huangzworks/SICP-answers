;;; 78-attach-tag.scm

(define (attach-tag type-tag contents)
    (if (number? contents)
        contents
        (cons type-tag contents)))
