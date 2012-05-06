;;; p123-put-and-get.scm

;;; init default pack table

(define table-size 100)

(define pack-table (make-equal-hash-table table-size))

;;; put

(define (put op type item)
    (if (hash-table/get pack-table op #f)                                           ; 查找二维表是否存在
        (hash-table/put! (hash-table/get pack-table op #f) type item)               ; 存在则直接将操作加入二维表
        (begin                                                                                
            (hash-table/put! pack-table op (make-equal-hash-table table-size))      ; 否则创建二维表，然后将操作加入
            (hash-table/put! (hash-table/get pack-table op #f) type item))))

;;; get

(define (get op type)
    (if (false? (hash-table/get pack-table op #f))                                  ; 查找一维表
        #f
        (hash-table/get (hash-table/get pack-table op #f) type #f)))                ; 查找二维表
