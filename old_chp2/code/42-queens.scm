;;; 42-queens.scm

(load "p83-flatmap.scm")
(load "p78-enumerate-interval.scm")

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter                                                         ; 过滤所有带有不安全皇后的棋盘
                (lambda (positions) (safe? k positions))
                (flatmap                                                    ; 生成棋盘，其中一部分带有不安全的皇后
                    (lambda (rest-of-queens)
                        (map (lambda (new-row)                              ; 将新皇后摆放到每一行
                            (adjoin-position new-row k rest-of-queens))
                        (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))                                ; 已有的 k-1 大小的皇后棋盘
    (queen-cols board-size))

(define (adjoin-position new-row col rest-of-queens)
    (cons new-row rest-of-queens))

(define empty-board '())

(define (safe? col positions)
    (no-collision? (car positions)          ; positions 的首个元素是新加的皇后所在的行
                   (cdr positions)          ; 其他元素是已经存在的皇后所在的行
                   1                        ; step 用于计算对角线
                   1                        ; 最左边界总为 1
                   (length positions)))     ; 最右边界为棋盘的边长

(define (no-collision? new-row rest-of-positions step left-most right-most)
    (if (null? rest-of-positions)   ; 如果所有皇后检查完毕
        #t                          ; 说明新加上的皇后是安全的
        (let ((current-row (car rest-of-positions)))                            ; 获取这一列的皇后所在的行
            (if (or (= current-row new-row)                                     ; 皇后上下冲突（水平线）
                    (= current-row (get-left-index new-row step left-most))     ; 左下右上对角线上的皇后冲突
                    (= current-row (get-right-index new-row step right-most)))  ; 右下左上对角线上的皇后冲突
                #f
                (no-collision? new-row
                               (cdr rest-of-positions)  ; 继续检查下一列的皇后
                               (+ 1 step)               ; 每次加一，调整对角线的位置
                               left-most
                               right-most)))))

(define (get-left-index row step left-most)
    (let ((index (- row step)))
        (if (< index left-most)     ; 越界
            -1
            index)))

(define (get-right-index row step right-most)
    (let ((index (+ row step)))
        (if (> index right-most)    ; 越界
            -1
            index)))


;;; 增加打印函数，方便观察计算出的棋盘

(define (display-boards n)
    (let ((boards (queens n)))
        (for-each (lambda (b)
            (begin
                (display b)
                (newline)))
            boards)))
