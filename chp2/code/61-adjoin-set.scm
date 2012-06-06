;;; 61-adjoin-set.scm

(define (adjoin-set x set)
    (if (null? set)
        (list x)
        (let ((current-element (car set))
              (remain-element (cdr set)))
            (cond ((= x current-element)
                    set)
                  ((> x current-element)
                    (cons current-element
                          (adjoin-set x remain-element)))
                  ((< x current-element)
                    (cons x set))))))
