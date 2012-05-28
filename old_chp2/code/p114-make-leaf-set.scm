;;; p114-make-leaf-set.scm

(load "p113-adjoin-set.scm")

(define (make-leaf-set pairs)
    (if (null? pairs)
        '()
        (let ((pair (car pairs)))
            (adjoin-set (make-leaf (car pair)   ; symbol
                                   (cadr pair)) ; frequency
                        (make-leaf-set (cdr pairs))))))
