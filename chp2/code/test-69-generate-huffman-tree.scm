(load "test-manager/load.scm")
(load "69-generate-huffman-tree.scm")

(define-each-check

    (equal? (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))
            (make-code-tree (make-leaf 'A 4)
                          (make-code-tree 
                            (make-leaf 'B 2)
                            (make-code-tree (make-leaf 'D 1)
                                            (make-leaf 'C 1)))))

)

(run-registered-tests)
