;;; 24-make-table.scm

(define (make-table same-key?)
    (let ((local-table (list '*table*)))
        (define (assoc key records)
            (cond ((null? records)
                    #f)
                  ((same-key? key (caar records))   ; 使用 same-key? 对比键
                    (car records))
                  (else
                    (assoc key (cdr records)))))
        (define (lookup key-1 key-2)
            (let ((subtable (assoc key-1 (cdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (cdr record)
                            #f))
                    #f)))
        (define (insert! key-1 key-2 value)
            (let ((subtable (assoc key-1 (cdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (set-cdr! record value)
                            (set-cdr! subtable
                                      (cons (key-2 value)
                                            (cdr subtable)))))
                    (set-cdr! local-table
                              (cons (list key-1
                                          (cons key-2 value))
                                    (cdr local-table)))))
            'ok)
        (define (dispatch m)
            (cond ((eq? m 'lookup-proc) lookup)
                  ((eq? m 'insert-proc!) insert!)
                  (else 
                    (error "Unknown operation -- TABLE" m))))
        dispatch))
