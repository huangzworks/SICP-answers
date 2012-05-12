;;; 23-deque.scm

; ptr selector

(define (front-ptr deque)
    (car deque))

(define (rear-ptr deque)
    (cdr deque))

; ptr setter

(define (set-front-ptr! deque item)
    (set-car! deque item))

(define (set-rear-ptr! deque item)
    (set-cdr! deque item))

; deque constructor

(define (make-deque)
    (cons '() '()))

; deque selector

(define (empty-deque? deque)
    (null? (front-ptr deque)))

(define (front-deque deque)
    (if (empty-deque? deque)
        (error "FRONT-DEQUE called with an empty deque" deque)
        (car (front-ptr deque))))

(define (rear-deque deque)
    (if (empty-deque? deque)
        (error "REAR-DEQUE called with an empty deque" deque)
        (car (rear-ptr deque))))

; deque setter

(define (insert-rear-deque! deque item)
    (let ((new-pair (cons item '())))
        (cond ((empty-deque? deque)
                (set-front-ptr! deque new-pair)
                (set-rear-ptr! deque new-pair)
                deque)
              (else
                (set-cdr! (rear-ptr deque) new-pair)
                (set-rear-ptr! deque new-pair)
                deque))))

(define (delete-front-deque! deque)
    (cond ((empty-deque? deque)
            (error "DELETE-FRONT-DEQUE! called with an empty deque" deque))
          (else
            (set-front-ptr! deque (cdr (front-ptr deque)))
            deque)))

(define (insert-front-deque! deque item)
    (cond ((empty-deque? deque)
            (insert-rear-deque! deque item))
          (else
            (set-front-ptr! deque (cons item (front-ptr deque)))
            deque)))

(define (delete-rear-deque! deque)
    (define (iter deque lst)
        (cond ((null? (cdr (cdr lst)))
                (set-cdr! lst '())
                (set-rear-ptr! deque lst)
                deque)
              (else
                (iter deque (cdr lst)))))
    (cond ((empty-deque? deque)
            (error "DELETE-REAR-DEQUE! called with an empty deque" deque))
          ((null? (cdr (front-ptr deque)))      ; 长度等于 1
            (set-front-ptr! deque '())
            deque)
          (else
            (iter deque (front-ptr deque)))))   ; 长度大于 1

;

(define (print-deque deque)
    (car deque))
