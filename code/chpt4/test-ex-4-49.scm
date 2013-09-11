;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-49

;; load ambeval analysis and interpretator
(load "chpt-4-3-2.scm")

;; load the extended verb phrase parser
(load "ex-4-49.scm")

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (generate-sentence)")
(newline)
(display ";;; then type 'try-again to find more")
(newline)
(display ";;; notice that they are however boring or nonesense")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
