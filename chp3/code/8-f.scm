;;; 8-f.scm

(define f
    (lambda (first-value)
        (set! f (lambda (second-value) 0))
        first-value))
