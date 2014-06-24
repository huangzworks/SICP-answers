;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-02
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.44
;;
;; Exercise 2.42 described the ``eight-queens puzzle'' of placing
;; queens on a chessboard so that no two attack each other. Write a
;; nondeterministic program to solve this puzzle.
;;
;; =============================================================================

;; test if the item is diagonal to one element in the list
;; the parameter number may be omit, instead we should use an internal variable
;; for simplificity we keep the number in parameter list.
;; the implementation of diagonal? is related to the order when the queen-list
;; is constructed
(ambeval '(define (diagonal? item list number)
            (if (null? list)
                false
                (let ((diff (- item (car list))))
                  (or (= diff (+ 1 (- number (length list))))
                      (= (- diff) (+ 1 (- number (length list))))
                      (diagonal? item (cdr list) number)))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the member? procedure
(ambeval '(define (member? item list)
            (if (null? list)
                false
                (if (equal? item (car list))
                    true
                    (member? item (cdr list)))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the eight-queens procedure
(ambeval '(define (eight-queens)
            (define (loop queen-list number)
              (if (= number 8)
                  queen-list
                  (let ((queen (amb 1 2 3 4 5 6 7 8)))
                    (require (not (member? queen queen-list)))
                    (require (not (diagonal? queen queen-list number)))
                    (loop (cons queen queen-list) (+ number 1)))))
            (loop '() 0))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
