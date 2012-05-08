;;; 6-rand.scm

(define random-init 1008611)

(define rand
    (let ((state random-init))
        (lambda (mode)
            (cond ((eq? mode 'generate)             ; 产生随机数
                    (random state))
                  ((eq? mode 'reset)                ; 返回一个过程
                    (lambda (new-value)             ; 这个过程将 state 修改为新值 new-value
                        (set! state new-value)
                        state))
                 (else
                    (error "Unknow mode -- RAND" mode))))))
