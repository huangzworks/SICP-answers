;;; 37-celsius-fahrenheit-converter.scm

(load "p205-constraint.scm")

(load "37-cv.scm")
(load "37-c-add.scm")
(load "37-c-sub.scm")
(load "37-c-mul.scm")
(load "37-c-div.scm")

(define (celsius-fahrenheit-converter x)
    (c+ (c* (c/ (cv 9) (cv 5))
            x)
        (cv 32)))

(define C (make-connector))
(define F (celsius-fahrenheit-converter C))
