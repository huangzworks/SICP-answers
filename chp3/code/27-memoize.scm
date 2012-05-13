;;; 27-memoize.scm

(define memoize
    (lambda (f)
        ((lambda (table)
            (lambda (x)
                ((lambda (previously-computed-result)
                    (or previously-computed-result
                        ((lambda (result)
                            (insert! x result table)
                            result)
                         (f x))))
                 (lookup x table))))
         (make-table))))
