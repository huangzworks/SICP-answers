;;; 2-make-monitored.scm

(define (make-monitored f)
    (let ((count-call 0))
        (lambda (input)
            (if (eq? input 'how-many-calls?)
                count-call
                (begin (set! count-call (+ 1 count-call))
                       (f input))))))
