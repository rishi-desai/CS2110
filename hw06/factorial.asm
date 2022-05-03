;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Factorial
;;=============================================================
;; Name: Rishi Desai
;;============================================================

;; In this file, you must implement the 'factorial' and "mult" subroutines.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'factorial' or 'mult' label.

;; Pseudocode

;; Factorial

;;    factorial(int n) {
;;        int ret = 1;
;;        for (int x = 2; x < n+1; x++) {
;;            ret = mult(ret, x);
;;        }
;;        return ret;
;;    }

;; Multiply
         
;;    mult(int a, int b) {
;;        int ret = 0;
;;        int copyB = b;
;;        while (copyB > 0):
;;            ret += a;
;;            copyB--;
;;        return ret;
;;    }


.orig x3000
    ;; you do not need to write anything here
HALT

factorial   ;; please do not change the name of your subroutine

    ;; build the stack
    ADD R6, R6, #-4		;; decrementing stack pointer, making space for RV, old RA, old FP, and LV1
	STR R5, R6, #1		;; pushing old R5 (FP)
	STR R7, R6, #2		;; pushing old R7 (RA)
	ADD R5, R6, #0		;; R5 = R6 + 0 = R6
    ADD R6, R6, #-5		;; decrement stack pointer, make space for saving the 5 registers R0-R4
	STR R0, R6, #0		;; pushing current R0
	STR R1, R6, #1		;; pushing current R1
	STR R2, R6, #2		;; pushing current R2
	STR R3, R6, #3		;; pushing current R3
	STR R4, R6, #4		;; pushing current R4

    ;; load n
    LDR R0, R5, #4      ;; R0 = n

    AND R1, R1, #0      ;; R1 = 0 (clear R0)
    ADD R1, R1, #1      ;; R1 = 1(ret)

    AND R2, R2, #0      ;; R2 = 0 (clear R0)
    ADD R2, R2, #2      ;; R2 = 2

FOR

    NOT R3, R2          ;; R3 = ~x
    ADD R3, R3, #1      ;; R3 = -x
    ADD R4, R0, #1      ;; R4 = n + 1
    ADD R4, R4, R3      ;; (n + 1) + (-x)
    BRnz ENDFOR         ;; if ((n + 1) - x >= 0), break out of loop
    
    ;; put x
    ADD R6, R6, #-1     ;; decrement R6
    STR R2, R6, #0      ;; mem[R6] = R2 = x

    ;; push ret
    ADD R6, R6, #-1     ;; decrement R6
    STR R1, R6, #0      ;; mem[R6] = R1 = ret

    JSR mult            ;; jump to mult subroutine
    LDR R1, R6, #0      ;; R1 = return value
    ADD R6, R6, #1      ;; increment stack pointer, popping return value
    ADD R6, R6, #2      ;; pop arguments off the stack

    ADD R2, R2, #1      ;; x++
    BRnzp FOR           ;; loop again

ENDFOR

    STR R1, R5, #3      ;; stores the return value to the RV slot
    BRnzp TEARDOWN

    
mult        ;; please do not change the name of your subroutine
    
    ;; build the stack
    ADD R6, R6, #-4		;; decrementing stack pointer, making space for RV, old RA, old FP, and LV1
	STR R5, R6, #1		;; pushing old R5 (FP)
	STR R7, R6, #2		;; pushing old R7 (RA)
	ADD R5, R6, #0		;; R5 = R6 + 0 = R6
    ADD R6, R6, #-5		;; decrement stack pointer, make space for saving the 5 registers R0-R4
	STR R0, R6, #0		;; pushing current R0
	STR R1, R6, #1		;; pushing current R1
	STR R2, R6, #2		;; pushing current R2
	STR R3, R6, #3		;; pushing current R3
	STR R4, R6, #4		;; pushing current R4

    ;; get arguments
    LDR R0, R5, #4      ;; R0 = a
    LDR R1, R5, #5      ;; R1 = b

    AND R2, R2, #0      ;; R2 = 0(ret) (clear R2)
    AND R3, R3, #0      ;; R3 = 0 (clear R3)
    ADD R3, R3, R1      ;; R3 = b

WHILE

    BRnz ENDWHILE       ;; if copy <= 0, break out of loop
    ADD R2, R2, R0      ;; R2 = ret + a
    ADD R3, R3, #-1     ;; b--
    BRnzp WHILE         ;; loop again

ENDWHILE

    STR R2, R5, #3      ;; stores the return value to the RV slot
    BRnzp TEARDOWN


;; tear down the stack
TEARDOWN

    LDR R0, R6, #0		;; restoring R0
	LDR R1, R6, #1		;; restoring R1
	LDR R2, R6, #2		;; restoring R2
	LDR R3, R6, #3		;; restoring R3
	LDR R4, R6, #4		;; restoring R4
	ADD R6, R5, #0		;; R6 = R5 + 0 = R5
	LDR R5, R6, #1		;; restores old frame pointer
	LDR R7, R6, #2		;; restores old return address 
	ADD R6, R6, #3      ;; pop RA, FP, LV1
    RET

STACK .fill xF000
.end
