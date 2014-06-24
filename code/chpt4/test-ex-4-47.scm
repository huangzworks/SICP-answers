;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-06
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-47

;; load ambeval analysis and interpretator
(load "chpt-4-3-2.scm")

;; load the new parse-verb-phrase
(load "ex-4-47.scm")

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (parse '(the professor lectures to the student))")
(newline)
(display ";;; then type 'try-again, you'll find it never returns")
(newline)
(display ";;; now type (set! parse-verb-phrase parse-verb-phrase-2)")
(newline)
(display ";;; then re-type the same parse command, you wait for a moment,")
(newline)
(display ";;; finally it aborts because out of memory")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
