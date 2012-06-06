(load "test-manager/load.scm")
(load "p112-huffman.scm")
(load "68-encode-symbol.scm")

(define t (make-code-tree (make-leaf 'A 4)
                          (make-code-tree 
                            (make-leaf 'B 2)
                            (make-code-tree (make-leaf 'D 1)
                                            (make-leaf 'C 1)))))

(define-each-check

    (equal? (encode-symbol 'A t)
            '(0))

    (equal? (encode-symbol 'D t)
            '(1 1 0))

)

(run-registered-tests)
