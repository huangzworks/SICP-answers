;;; 5-random-in-range.scm

(define (random-in-range low high)
    (let ((range (- high low)))
        (+ low 
           (random (exact->inexact range)))))  ; 确保生成浮点随机数
