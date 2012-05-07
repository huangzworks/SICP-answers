;;; 82-driver.scm

(load "p129-install-scheme-number-package.scm")
(load "p129-install-rational-package.scm")

(load "p133-coercion.scm")

(load "p129-generic-op.scm")                            ; 载入 add 、 sub 等操作
(load "82-apply-generic.scm")                           ; 必须在 p129-generic-op.scm 之后载入，确保重载 apply-generic 

(load "p119-attach-tag-and-type-tag-and-contents.scm")  ; 载入 contents

;; 安装包

(install-scheme-number-package)
(install-rational-package)

;; 强制函数

(define (scheme-number->rational number)
    (make-rational (contents number) 1))

(put-coercion 'scheme-number 'rational scheme-number->rational)
