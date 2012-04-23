;;; p83-make-pair-sum.scm

(define (make-pair-sum pair)
    (let ((x (car pair))
          (y (cadr pair)))
        (list x y (+ x y))))
