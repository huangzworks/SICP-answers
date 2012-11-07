;;; 29-mobile-balance.scm

(load "29-left-branch-and-right-branch.scm")        ; 载入 left-branch 和 right-branch
(load "29-branch-length-and-branch-structure.scm")  ; 载入 branch-structure
(load "29-branch-torque.scm")                       ; 载入 branch-torque

(define (mobile-balance? mobile)
    (let ((left (left-branch mobile))
          (right (right-branch mobile)))
        (and                                        ; 必须同时满足以下三个条件，才是平衡的活动体
            (same-torque? left right)
            (branch-balance? left)
            (branch-balance? right))))

(define (same-torque? left right)
    (= (branch-torque left)
       (branch-torque right)))

(define (branch-balance? branch)
    (if (hangs-another-mobile? branch)              ; 如果分支上有子活动体
        (mobile-balance? (branch-structure branch))  ; 那么(递归地)检查子活动体的平衡性
        #t))                                        ; 否则，返回 #t
