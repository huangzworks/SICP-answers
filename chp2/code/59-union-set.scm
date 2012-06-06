;;; 59-union-set.scm

(load "p103-element-of-set.scm")

(define (union-set set1 set2)
    (iter (append set1 set2) '()))

(define (iter input result)
    (if (null? input)
        (reverse result)
        (let ((current-element (car input))
              (remain-element (cdr input)))
            (if (element-of-set? current-element result)
                (iter remain-element result)
                (iter remain-element
                      (cons current-element result))))))
