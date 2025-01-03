; Author:
; Date Created:
; Date Modified:
; Description:
; Usage:

; -------------------

; defines most global variables

(defvar *falsy* nil)
(defvar *truthy* t)
(defvar *game_in_play* t)
(defvar *found_a_match* *falsy*)
(defvar *three-in-a-row* 0)
(defvar *round_counter* 0)
(defvar *mark* 'X)
(defvar *board_spots*)
; play_again_input, spot_to_fill

(defun set-board-values ()
  (setf *board_spots* (make-array '(9)))
  (setf (aref *board_spots* 0) '1)
  (setf (aref *board_spots* 1) '2)
  (setf (aref *board_spots* 2) '3)
  (setf (aref *board_spots* 3) '4)
  (setf (aref *board_spots* 4) '5)
  (setf (aref *board_spots* 5) '6)
  (setf (aref *board_spots* 6) '7)
  (setf (aref *board_spots* 7) '8)
  (setf (aref *board_spots* 8) '9))
  ;(write *board_spots*)
; test function list main functions I need to create and test

;(defun my-t3-list ()
  ;(format t '"The variable game_over is set to: ")
  ;(print *game_over*)
  ;(format t '"and the varialble found_a_match is set to: ")
  ;(print *found_a_match*)  
  ;(terpri))

;'(defun announce-three ()
;  (or (if (and (= *game_over* *false*) (= *found_a_match* (not *false*))) (print '(You found three in a row!))) (if (= *game_over* *false*) (print '(Keep looking for a match!))))
;  (terpri))(defun announce-game-over ()

(defun my-functions ()
  (print '(t3-functions (announce-three-in-a-row find-three-in-a-row attempt-to-fill-spot reset-pregame-variables say-invaid)))
  (terpri))

(defun display-info ()
  (terpri)
  (if (= *round_counter* 9) (and (and (format t '"Last Round!") (and (terpri) (terpri)))))
  (terpri)
  (format t '"Current Round is: ")(print *round_counter*)
  (terpri)
  (format t '"Current Turn goes to: ")(print *mark*)
  (terpri)(terpri))

(defun change-turn ()
  (if (= 1 (mod *round_counter* 2)) (setf *mark* 'X))
  (if (= 0 (mod *round_counter* 2)) (setf *mark* 'O)))

(defun printem (&rest args)
      (format t '"~{~a~^ ~}" args))

(defun draw-board ()
  (terpri)
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (printem '"   " (aref *board_spots* 0) '"   !   " (aref *board_spots* 1) '"   !   " (aref *board_spots* 2))
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (format t '"_________!_________!_________")
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (printem '"   " (aref *board_spots* 3) '"   !   " (aref *board_spots* 4) '"   !   " (aref *board_spots* 5))
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (format t '"_________!_________!_________")
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (printem '"   " (aref *board_spots* 6) '"   !   " (aref *board_spots* 7) '"   !   " (aref *board_spots* 8))
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (format t '"         !         !         ")
  (terpri)
  (terpri))

;(setf *game_over* 'true *found_a_match* 'true)
  ;(print '"The variable game_over is set to: ")
  ;(print *game_over*)
  ;(print '"and the varialble found_a_match is set to: ")
  ;(print *found_a_match*)
  ;(terpri)

(defun read-move ()
  (setq temp-input (read))
  ;(format t '"This is your temp input: ")
  ;(write temp-input)
  (setf (aref *board_spots* (- temp-input 1)) *mark*)
  (terpri))

(defun player-move ()
  (format t '"Please select a spot to place your mark:")
  (terpri)
  (read-move)
  (terpri)(terpri))

(defun announce-tie ()
  (format t '"Looks like no clear winner, this time"))

(defun announce-win ()
  (format t '"A player has won!"))

(defun tie-or-zero-sum ()
  (or (if (< *three-in-a-row* 1) (announce-tie)) (if (= *three-in-a-row* 1) (announce-win))))

(defun announce-game-over ()
  (terpri)(terpri)
  (format t '"No more rounds!")
  (terpri)(terpri)
  (tie-or-zero-sum)
  (terpri)(terpri))

(defun test-to-speak ()
  (if (not *game_in_play*) (announce-game-over)))

(defun round-limit-checker ()
  (if (= *round_counter* 9) (setf *game_in_play* (not t))))
    ;(and (setf *game_in_play* (not t)) (test-func))))
; evidently this works because with only calling test-func, it enters an infinite loop
  ;(if (= *round_counter* 9) (ask-to-play-again)))

(defun late-helper-functions ()
  (round-limit-checker)
  (test-to-speak))

(defun early-helper-functions ()
  (change-turn)
  (display-info))

(defun start-game ()
  (set-board-values)
  (draw-board)
  (loop while (< *round_counter* 9)
        do (setf *round_counter* (+ *round_counter* 1))
           (terpri)(terpri)
	   (early-helper-functions)
	   (player-move)
	   ;(test-input-draw-board)
	   (draw-board)
	   (late-helper-functions)))

(defun reset-pregame-variables ()
  (format t '"Resetting values so game can restart")
  (setf *game_in_play* t)
  (setf *round_counter* 0)
  (set-board-values))

(defun take-endgame-input ()
  (let ((p nil))
    (setf p (read))
    (print (append '(You said ) (list p)))
    (terpri)
    (terpri)
    (format t '"Okay, restarting now!")
    (terpri)
    (terpri)
    (terpri)))
; if yes, call reset-pregame-variables, then start-game

(defun speak-question ()
  (format t '"Would you like to play again?"))

(defun ask-to-play ()
  (speak-question)
  (take-endgame-input)
  (reset-pregame-variables)
  (start-game))

(defun main-play-loop ()
  (setf *game_in_play* t)
  (loop while *game_in_play*
        do (terpri)(terpri)
	(start-game)
	(ask-to-play)))
