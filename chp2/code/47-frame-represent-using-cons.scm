;;; 47-frame-represent-using-cons.scm

(define (make-frame origin edge1 edge2)
    (cons origin
          (cons edge1 edge2)))

(define (origin-frame f)
    (car f))

(define (edge1-frame f)
    (cadr f))

(define (edge2-frame f)
    (cddr f))
