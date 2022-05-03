;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - summation
;;=============================================================
;; Name: Rishi Desai
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;;    int result; (to save the summation of x)
;;    int x= -9; (given integer)
;;    int answer = 0;
;;    while (x > 0) {
;;        answer += x;
;;        x--;
;;    }
;;    result = answer;
.orig x3000

    LD  R0, x                   ; R0 = x
    AND R1, R1, #0              ; R1 = sum
    
    WHILE   ADD R0, R0, #0      ; R0 = x + 0, sets the CC of x
            BRnz ENDWHILE       ; if (x <= 0), break out of loop

            ADD R1, R1, R0      ; R1 = sum + x
            ADD R0, R0, -1      ; R0 = x--

            BRp WHILE           ; if (x > 0) go back and loop again

    ENDWHILE 
        ST R1, result           ; store the result
    
    HALT

    x .fill -9
    result .blkw 1
.end

