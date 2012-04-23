;;; 41-unique-triples.scm

(load "p78-enumerate-interval.scm")
(load "p83-flatmap.scm")
(load "40-unique-pairs.scm")

(define (unique-triples n)
    (flatmap (lambda (i)
                 (map (lambda (j)                   ; cons 起 i 元素和二元组 j ，组成三元组
                          (cons i j))
                      (unique-pairs (- i 1))))      ; 生成不大于 i 的所有相异整数二元组
             (enumerate-interval 1 n)))             ; 生成 1 至 n 的所有整数，作为 i 
