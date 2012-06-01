;;; 42-queens.scm

(load "p78-enumerate-interval.scm")
(load "p83-flatmap.scm")

(load "42-safe.scm")
(load "42-empty-board.scm")
(load "42-adjoin-position.scm")

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions)
                    (safe? k positions))
                (flatmap
                    (lambda (rest-of-queens)
                        (map (lambda (new-row)
                                 (adjoin-position new-row k rest-of-queens))
                             (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
    (queen-cols board-size))
