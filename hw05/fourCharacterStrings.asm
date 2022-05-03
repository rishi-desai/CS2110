;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - fourCharacterStrings
;;=============================================================
;; Name: Rishi Desai
;;=============================================================


;; Pseudocode (see PDF for explanation)
;;
;; int count = 0;
;; int chars = 0;
;; int i = 0;
;;
;;  while(str[i] != '\0') {
;;      if (str[i] != ' ') 
;;          chars++;
;;      
;;      else {
;;          if (chars == 4)  {
;;              count++;
;;			}
;;          chars = 0;
;;      }
;;      i++;
;;  }
;; ***IMPORTANT***
;; - Assume that all strings provided will end with a space (' ').
;; - Special characters do not have to be treated differently. For instance, strings like "it's" and "But," are considered 4 character strings.
;;

.orig x3000
	
			AND R0, R0, #0			; R0 = count
			AND R1, R1, #0			; R1 = chars
			AND R2, R2, #0			; R2 = i
			LD R3, SPACE			; R4 = SPACE
			LD R6, ANSWER			; R6 = ANSWER

	WHILE	LD R4, STRING    	; R4 = address of STRING
            ADD R4, R4, R2          ; R4 = address of STRING[i]
            LDR R4, R4, #0          ; R4 = STRING[i]

			BRz ENDWHILE			; if STRING[i] == '/0', break the loop

			ADD R5, R4, R3			; R5 = STRING[i] + SPACE

			BRz ISSPACE				; if (STRING[i] == SPACE), branch to ISSPACE
			ADD R1, R1, #1			; chars++
			BRnzp CONT

		ISSPACE
			ADD R5, R1, #-4			; R5 = chars - 4
			BRnp NOTFOUR			; if (chars != 4), branch to NOTFOUR
			ADD R0, R0, #1			; count++

		NOTFOUR
			AND R1, R1, #0			; chars = 0

		CONT
			ADD R2, R2, #1			; i++

		BRnzp WHILE					; go back and loop again

	ENDWHILE

			ST R0, ANSWER			; ANSWER = count

	HALT


SPACE 	.fill #-32
STRING	.fill x4000
ANSWER .blkw 1

.end


.orig x4000

.stringz "I love CS 2110 and assembly is very fun! "

.end
