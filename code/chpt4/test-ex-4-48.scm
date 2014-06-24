;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-10
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-48

;; load ambeval analysis and interpretator
(load "chpt-4-3-2.scm")

;; load the extended verb phrase parser
(load "ex-4-48.scm")

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (parse '(the professor kindly lectures to the student))")
(newline)
(display ";;; then type 'try-again until it gives no more possibility")
(newline)
(display ";;; now type (parse '(the professor lectures to the student kindly))")
(newline)
(display " and type 'try-again until it ends")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
