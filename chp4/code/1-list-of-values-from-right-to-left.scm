;;; 1-list-of-values-from-right-to-left.scm

(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (let ((rest-values (list-of-values (rest-operands exps) env)))
            (cons (eval (first-operand exps) env)
                  rest-values))))
