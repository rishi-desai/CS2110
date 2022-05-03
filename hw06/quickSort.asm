;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Quick Sort
;;=============================================================
;; Name:
;;============================================================

;; In this file, you must implement the 'quicksort' and 'partition' subroutines.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'quicksort' or 'partition' label.


;; Pseudocode:

;; Partition

;;    partition(int[] arr, int low, int high) {
;;        int pivot = arr[high];
;;        int i = low - 1;
;;        for (j = low; j < high; j++) {
;;            if (arr[j] < pivot) {
;;                i++;
;;                int temp = arr[j];
;;                arr[j] = arr[i];
;;                arr[i] = temp;
;;            }
;;        }
;;        int temp = arr[high];
;;        arr[high] = arr[i + 1];
;;        arr[i + 1] = temp;
;;        return i + 1;
;;    }
        
;; Quicksort

;;    quicksort(int[] arr, int left, int right) {
;;        if (left < right) {
;;            int pi = partition(arr, left, right);
;;            quicksort(arr, left, pi - 1);
;;            quicksort(arr, pi + 1, right);
;;        }
;;    }


.orig x3000
    ;; you do not need to write anything here
HALT

partition   ;; please do not change the name of your subroutine
    
    ;; build the stack
    ADD R6, R6, #-4         ;; decrement stack pointer, allocate space for RV, old RA, old FP, LV1
    STR R5, R6, #1          ;; pushing R5 (old FP)
    STR R7, R6, #2          ;; pushing R7 (old RA)
    ADD R5, R6, #0          ;; R5 = R6
    ADD R6, R6, #-5         ;; decrement stack pointer, allocate space for 5 registers (R0-R4) 
    STR R0, R5, #-1         ;; pushing current R0
    STR R1, R5, #-2         ;; pushing current R1
    STR R2, R5, #-3         ;; pushing current R2
    STR R3, R5, #-4         ;; pushing current R3
    STR R4, R5, #-5         ;; pushing current R4

    ;; get arguments
    LDR R1, R5, #5          ;; R1 = low  (j)

    ;; local variables
    ADD R3, R1, #-1         ;; R3 = low - 1  (i)
    
FOR 

    LDR R2, R5, #6          ;; R2 = high
    NOT R4, R1              ;; R4 = ~j
    ADD R4, R4, #1          ;; R4 = -j
    ADD R4, R2, R4          ;; R4 = high - j
    BRnz ENDFOR             ;; if (j >= high), break out of loop

    LDR R0, R5, #4          ;; R0 = arr
    ADD R0, R0, R2          ;; R0 = address of arr[high]
    LDR R0, R0, #0          ;; R0 = arr[high]  (pivot)
    LDR R2, R5, #4          ;; R0 = arr
    ADD R2, R2, R1          ;; R2 = address of arr[j]
    LDR R2, R2, #0          ;; R2 = arr[j]
    NOT R4, R2              ;; R4 = ~arr[j]
    ADD R4, R4, #1          ;; R4 = -arr[j]
    ADD R4, R0, R4          ;; R4 = pivot - arr[j]

    BRnz IF1                 ;; if (arr[j] <= pivot), branch to IF1

    ADD R3, R3, #1          ;; i++
    AND R4, R4, #0          ;; clear R4
    ADD R4, R4, R2          ;; R4 = arr[j]
    LDR R0, R5, #4          ;; R0 = arr
    ADD R0, R0, R3          ;; R0 = address of arr[i]
    LDR R0, R0, #0          ;; R0 = arr[i]

    LDR R2, R5, #4          ;; R2 = arr
    ADD R2, R2, R1          ;; R2 = address of arr[j]
    STR R0, R2, #0          ;; arr[j] = arr[i]

    LDR R0, R5, #4          ;; R0 = arr
    ADD R0, R0, R3          ;; R0 = address of arr[i]
    STR R4, R0, #0          ;; arr[i] = temp
IF1
    ADD R1, R1, #1          ;; j++
    BRnzp FOR               ;; go back and loop

ENDFOR

    LDR R0, R5, #4          ;; R0 = arr
    ADD R0, R0, R2          ;; R0 = address of arr[high]
    LDR R0, R0, #0          ;; R0 = arr[high]
    LDR R2, R5, #4          ;; R2 = arr
    ADD R2, R2, R1          ;; R2 = address of arr[high]
    LDR R4, R5, #4          ;; R4 = arr
    ADD R3, R3, #1          ;; i + 1
    ADD R4, R4, R3          ;; R4 = address of arr[i + 1]
    LDR R4, R4, #0          ;; R4 = arr[i + 1]
    STR R4, R2, #0          ;; arr[high] = arr[i + 1]
    LDR R2, R5, #4          ;; R2 = arr
    ADD R2, R2, R3          ;; R2 = address of arr[i + 1]
    STR R0, R2, #0          ;; arr[i + 1] = temp

    STR R3, R5, #3          ;; stores the return value to the RV slot
    BRnzp TEARDOWN


quicksort   ;; please do not change the name of your subroutine
    
    ;; build the stack
    ADD R6, R6, #-4         ;; decrement stack pointer, allocate space for RV, old RA, old FP, LV1
    STR R5, R6, #1          ;; pushing R5 (old FP)
    STR R7, R6, #2          ;; pushing R7 (old RA)
    ADD R5, R6, #0          ;; R5 = R6
    ADD R6, R6, #-5         ;; decrement stack pointer, allocate space for 5 registers (R0-R4) 
    STR R0, R5, #-1         ;; pushing current R0
    STR R1, R5, #-2         ;; pushing current R1
    STR R2, R5, #-3         ;; pushing current R2
    STR R3, R5, #-4         ;; pushing current R3
    STR R4, R5, #-5         ;; pushing current R4

    ;; get arguments
    LDR R0, R5, #4          ;; R0 = arr
    LDR R1, R5, #5          ;; R1 = left
    LDR R2, R5, #6          ;; R2 = right

    NOT R3, R1              ;; R3 = ~left
    ADD R3, R3, #1          ;; R3 = -left
    ADD R3, R2, R3          ;; R3 = right - left

    BRnz IF2                ;; if (left >= right), branch to IF1

    ;; push right
    ADD R6, R6, #-1     ;; decrement R6
    STR R2, R6, #0      
    ;; push left
    ADD R6, R6, #-1     ;; decrement R6
    STR R1, R6, #0      
    ;; push arr
    ADD R6, R6, #-1     ;; decrement R6
    STR R0, R6, #0      
    JSR partition
    LDR R3, R6, #0      ;; R3 = return value
    ADD R6, R6, #1      ;; increment stack pointer, popping return value
    ADD R6, R6, #3      ;; pop arguments off the stack

    ;; push pi - 1
    ADD R4, R3, #-1     ;; R4 = pi - 1
    ADD R6, R6, #-1     ;; decrement R6
    STR R4, R6, #0      
    ;; push left
    ADD R6, R6, #-1     ;; decrement R6
    STR R1, R6, #0      
    ;; push arr
    ADD R6, R6, #-1     ;; decrement R6
    STR R0, R6, #0
    JSR quicksort
    ADD R6, R6, #3      ;; pop arguments off the stack

    ;; push right
    ADD R6, R6, #-1     ;; decrement R6
    STR R2, R6, #0   
    ;; push pi + 1
    ADD R4, R3, #1      ;; R4 = pi + 1
    ADD R6, R6, #-1     ;; decrement R6
    STR R4, R6, #0      
     ;; push arr
    ADD R6, R6, #-1     ;; decrement R6
    STR R0, R6, #0
    JSR quicksort
    ADD R6, R6, #3      ;; pop arguments off the stack

IF2


;; teardown the stack
TEARDOWN

    LDR R0, R5, #-1         ;; restoring current R0
    LDR R1, R5, #-2         ;; restoring current R1
    LDR R2, R5, #-3         ;; restoring current R2
    LDR R3, R5, #-4         ;; restoring current R3
    LDR R4, R5, #-5         ;; restoring current R4
    ADD R6, R5, #0          ;; R6 = R5 (restoring old stack pointer)
    LDR R5, R6, #1          ;; restoring old FP
    LDR R7, R6, #2          ;; restoring old RA
    ADD R6, R6, #3          ;; pop LV1, old FP, and old RA
    RET

STACK .fill xF000
.end


;; Assuming the array starts at address x4000, here's how the array [1,3,2,5] represents in memory
;; Memory address           Data
;; x4000                    1
;; x4001                    3
;; x4002                    2
;; x4003                    5
