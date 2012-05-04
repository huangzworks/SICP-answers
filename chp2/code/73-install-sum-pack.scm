;;; 73-install-sum-pack.scm

(define (install-sum-pack)
    ;;; internal procedures 

    (define (addend s)
        (car s))

    (define (augend s)
        (cadr s))

    (define (make-sum x y)
        (list '+ x y))

    ;;; interface to the rest of the system

    ; sum 包自己并不需要在外部调用 make-sum 函数
    ; 这是导出给乘法求导程序用的
    (put 'make-sum '+ make-sum)

    (put 'deriv '+
        (lambda (exp var)
            (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var))))

'done)
