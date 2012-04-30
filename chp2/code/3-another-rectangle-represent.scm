;;; 3-another-rectangle-represent.scm

(define (make-rectangle length width)
    (cons length width))

(define (length-rectangle r)
    (car r))

(define (width-rectangle r)
    (cdr r))
