;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - buildMaxArray
;;=============================================================
;; Name: Rishi Desai
;;=============================================================


;; Pseudocode (see PDF for explanation)
;;
;;	int A[] = {1,2,3};
;;	int B[] = {-1, 7, 8};
;;	int C[3];
;;
;;	int i = 0;
;;
;;	while (i < A.length) {
;;		if (A[i] < B[i])
;;			C[i] = B[i];
;;		else
;;			C[i] = A[i];
;;
;;		i += 1;
;;	}

.orig x3000
	
			AND R0, R0, #0	; i = R0

	WHILE	LD R1, LEN		; R1 = LEN
			NOT R1, R1
			ADD R1, R1, #1	; R1 = -LEN
			ADD R1, R0, R1	; R1 = i + (-LEN)
			BRzp ENDWHILE	; if (i - LEN >= 0), break out of the loop

			LD R1, A		; R1 = address of A
			ADD R1, R1, R0	; R1 = address of A[i]
			LDR R2, R1, #0	; R2 = A[i]

			LD R1, B		; R1 = address of B
			ADD R1, R1, R0	; R1 = address of B[i]
			LDR R3, R1, #0	; R3 = B[i]

			LD R1, C		; R1 = address of C
			ADD R1, R1, R0	; R3 = address of C[i]

			NOT R5, R2
			ADD R5, R5, #1	; R5 = -A[i]

			;; if the result is positive, then A[i] < B[i]
			;; if the result is negative or zero, then A[i] > B[i]
			ADD R5, R5, R3	; R5 = (-A[i]) + B[i]

			BRnz AGREATER	; if A[i] > B[i] (cc negative or zero), branch to AGREATER
			STR R3, R1, #0	; C[i] = B[i]
			BRnzp CONT

		AGREATER
			STR R2, R1, #0	; C[i] = A[i]
		CONT

			ADD R0, R0, #1	; i++

			BRnzp WHILE		; go back and loop again

	ENDWHILE

	HALT


A 	.fill x3200
B 	.fill x3300
C 	.fill x3400
LEN .fill 4

.end

.orig x3200
	.fill -1
	.fill 2
	.fill 7
	.fill -3
.end

.orig x3300
	.fill 3
	.fill 6
	.fill 0
	.fill 5
.end

.orig x3400
	.blkw 4
.end


