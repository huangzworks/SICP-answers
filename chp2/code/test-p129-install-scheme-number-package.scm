(load "test-manager/load.scm")

(load "p129-install-scheme-number-package.scm")
(load "p129-generic-op.scm")

;; install package
(install-scheme-number-package)

;; data
(define x (make-scheme-number 10))

(define y (make-scheme-number 5))

;; test
(define-each-check

    (equal? (type-tag x)
            'scheme-number)

    (equal? (contents x)
            10)

    (equal? (contents (add x y))
            15)

    (equal? (contents (sub x y))
            5)

    (equal? (contents (mul x y))
            50)

    (equal? (contents (div x y))
            2)

)

(run-registered-tests)
