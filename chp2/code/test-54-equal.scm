(load "test-manager/load.scm")
(load "54-equal.scm")

(define-test (test-symbol-equal?)
    
    (check (equal? 'symbol 'symbol))

    (check (false? (equal? 'symbol 'another-symbol)))

)

(define-test (test-list-equal?-with-empty-list)
    
    (check (equal? '() '()))

)

(define-test (test-list-equal?-with-different-length)
    
    (check (false? (equal? '() 
                           (list 'a 'b 'c))))

    (check (false? (equal? (list 'a 'b 'c)
                           '())))

)

(define-test (test-list-equal?-in-normal-case)
    
    (check (equal? (list 'a 'b 'c)
                   (list 'a 'b 'c)))

    (check (false? (equal? (list 'a 'b 'c)
                           (list 'apple 'banana 'candy))))

)

(run-registered-tests)
