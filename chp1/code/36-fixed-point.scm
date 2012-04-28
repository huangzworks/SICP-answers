;;; 36-fixed-point.scm

(define tolerance 0.000001)

(define (fixed-point f first-guess)
                
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))

    (define (try guess step)
        (display-info guess step)                       ; 每次进入测试时打印一次猜测
        (let ((next (f guess)))
            (if (close-enough? next guess)
                (begin                                  ; 如果猜测完成
                    (display-info next (+ 1 step))      ; 记得算上最后一次计算 next 的猜测
                    next)
                (try next (+ 1 step)))))

    (try first-guess 1))

(define (display-info guess step)
    (display "Step: ")
    (display step)
    (display " ")
    
    (display "Guess: ")
    (display guess)
    (newline))
