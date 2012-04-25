;;; 47-selector-for-make-frame-using-cons.scm

(define (origin-frame frame)
    (car frame))

(define (edge1-frame frame)
    (cadr frame))

(define (edge2-frame frame)
    (cddr frame))
