;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-06
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-45

;; load ambeval analysis and interpretator
(load "chpt-4-3-2.scm")

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (parse")
(newline)
(display ";;;        '(The professor lectures to the student")
(newline)
(display ";;;          in the class with the cat)")
(newline)
(display ";;; then type 'try-again to find the other 4 meaning")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
