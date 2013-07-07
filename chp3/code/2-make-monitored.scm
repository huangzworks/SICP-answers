;;; 2-make-monitored.scm

(define (make-monitored f)
    (let ((count-call 0))
        (lambda (input)
            (cond ((eq? input 'how-many-calls?)
                   count-call)
                  ((eq? input 'reset-count)
                   (begin (set! count-call 0)
                          count-call))
                  (else (begin (set! count-call (+ 1 count-call))
                               (f input)))))))
