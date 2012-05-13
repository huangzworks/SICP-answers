;;; 26-table.scm

(load "26-tree.scm")

(define (make-table compare)
    (let ((t '()))

        (define (empty?)
            (tree-empty? t))

        (define (insert! given-key value)
            (set! t (tree-insert! t given-key value compare))
            'ok)

        (define (lookup given-key)
            (let ((result (tree-search t given-key compare)))
                (if (null? result)
                    #f
                    (tree-value result))))

        (define (dispatch m)
            (cond ((eq? m 'insert!)
                    insert!)
                  ((eq? m 'lookup)
                    lookup)
                  ((eq? m 'empty?)
                    (empty?))
                  (else
                    (error "Unknow mode " m))))

        dispatch))
