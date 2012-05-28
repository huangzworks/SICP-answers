;;; p133-coercion.scm

(define coercion-table-size 100)

(define coercion-table (make-equal-hash-table coercion-table-size))

;;; put-coercion

(define (put-coercion from to proc)
    (if (hash-table/get coercion-table from #f)
        (hash-table/put! (hash-table/get coercion-table from #f) to proc)
        (begin
            (hash-table/put! coercion-table from (make-equal-hash-table coercion-table-size))
            (hash-table/put! (hash-table/get coercion-table from #f) to proc))))

;;; get-coercion

(define (get-coercion from to)
    (if (false? (hash-table/get coercion-table from #f))
        #f
        (hash-table/get (hash-table/get coercion-table from #f) to #f)))
