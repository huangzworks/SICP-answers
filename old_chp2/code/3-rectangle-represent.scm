;;; 3-rectangle-represent.scm

;; constructor

(define (make-rectangle length-1 length-2 width-1 width-2)
    (cons (cons length-1 length-2)
          (cons width-1 width-2)))

;; selector

(define (length-1-rectangle r)
    (car (car r)))

(define (length-2-rectangle r)
    (cdr (car r)))

(define (width-1-rectangle r)
    (car (cdr r)))

(define (width-2-rectangle r)
    (cdr (cdr r)))
