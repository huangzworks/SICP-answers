(load "test-manager/load.scm")
(load "32-rec-accumulate.scm")

(define-each-check

    (= (* 1 2 3 4 5)
       (accumulate *
                   1
                   (lambda (x) x)
                   1
                   (lambda (i) (+ i 1))
                   5))

)

(run-registered-tests)
