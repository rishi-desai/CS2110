;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - binaryStringToInt
;;=============================================================
;; Name: Rishi Desai
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;;    int result = x4000; (given memory address to save the converted value)
;;    String binaryString= "01000000"; (given binary string)
;;    int length = 8; (given length of the above binary string)
;;    int base = 1;
;;    int value = 0;
;;    while (length > 0) {
;;        int y = binaryString.charAt(length - 1) - 48;
;;        if (y == 1) {
;;            value += base;
;;        }     
;;            base += base;
;;            length--;
;;    }
;;    mem[result] = value;

.orig x3000
    
            AND R0, R0, #0	        ; clear R0
            ADD R0, R0, #1          ; R0 = base

            AND R1, R1, #0	        ; R1 = value

            LD R4, result           ; R4 = result

            LD R2, length           ; R2 = length
            ADD R2, R2, #-1         ; R2 = length - 1

    WHILE   BRn ENDWHILE           ; if (length <= 0), break out of loop

            LD R3, binaryString    ; R3 = address of binaryString
            ADD R3, R3, R2          ; R3 = address of binaryString char at i
            LDR R3, R3, #0          ; R3 = binaryString char at i

            AND R3, R3, #1          ; checks if the binaryString char at i is 1 or 0, set CC

            BRz CONT                ; if binaryString char at i is 0, branch to CONT
            ADD R1, R1, R0          ; R1 = value + base
            CONT

            ADD R0, R0, R0          ; R0 = base + base

            ADD R2, R2, #-1         ; length--

            BRnzp WHILE             ; go back and loop

    ENDWHILE

            STR R1, R4, #0          ; result = value

    HALT

    binaryString .fill x5000
    length .fill 8
    result .fill x4000
.end 

.orig x5000
    .stringz "010010100"
.end
