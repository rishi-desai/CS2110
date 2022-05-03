;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Binary Search
;;=============================================================
;; Name:
;;============================================================

;; In this file, you must implement the 'binarySearch' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'binarySearch' label.


;; Pseudocode:

;; Nodes are blocks of size 3 in memory:

;; The data is located in the 1st memory location
;; The node's left child address is located in the 2nd memory location
;; The node's right child address is located in the 3rd memory location

;; Binary Search

;;    binarySearch(Node root (addr), int data) {
;;        if (root == 0) {
;;            return 0;
;;        }
;;        if (data == root.data) {
;;            return root;
;;        }
;;        if (data < root.data) {
;;            return binarySearch(root.left, data);
;;        }
;;        return binarySearch(root.right, data);
;;    }

.orig x3000
    ;; you do not need to write anything here
HALT

binary_search   ;; please do not change the name of your subroutine
    
    ;; build the stack
    ADD R6, R6, #-4         ;; decrement SP, allocate space for RV, old RA, old FP, and LV1
    STR R5, R6, #1          ;; pushing old frame pointer
    STR R7, R6, #2          ;; pushing old RA
    ADD R5, R6, #0          ;; FP = SP
    ADD R6, R6, -5          ;; decrement SP, allocate space for 5 registers
    STR R0, R5, #-1         ;; pushing register R0
    STR R1, R5, #-2         ;; pushing register R1
    STR R2, R5, #-3         ;; pushing register R2
    STR R3, R5, #-4         ;; pushing register R3
    STR R4, R5, #-5         ;; pushing register R4

    ;; load arguments
    LDR R1, R5, #5          ;; R1 = data
    LDR R0, R5, #4          ;; R0 = root

    BRz IF1                 ;; if (root == 0)

    LDR R2, R0, #0          ;; R2 = root.data
    NOT R3, R1              ;; ~data
    ADD R3, R3, #1          ;; -data
    ADD R2, R2, R3          ;; R2 = root.data - data

    BRz IF2                 ;; if (data == root.data)
    BRp IF3                 ;; if (data < root.data)

    ; return binarySearch(root.right, data);

     ;; push data
    ADD R6, R6, #-1         ;; decrement SP
    STR R1, R6, #0          ;; pushing data

    ;; push root.right
    ADD R6, R6, #-1         ;; decrement SP
    LDR R2, R0, #2          ;; address of root.right
    STR R2, R6, #0          ;; pushing root.right

    JSR binary_search        ;; recursive call to right child

    ;; pop RV
    LDR R2, R6, #0          ;; R2 = RV
    ADD R6, R6, #3          ;; popping RV and arguments

    STR R2, R5, #3          ;; RV = binarySearch(root.right, data)
    BRnzp TEARDOWN          

IF1
    ; return 0;

    AND R2, R2, #0          ;; clear R2
    STR R2, R5, #3          ;; RV = 0
    BRnzp TEARDOWN

IF2
    ; return root;

    STR R0, R5, #3          ;; RV = root
    BRnzp TEARDOWN

IF3
    ; return binarySearch(root.left, data);

    ;; push data
    ADD R6, R6, #-1         ;; decrement SP
    STR R1, R6, #0          ;; pushing data

    ;; push root.left
    ADD R6, R6, #-1         ;; decrement SP
    LDR R2, R0, #1          ;; address of root.left
    STR R2, R6, #0          ;; pushing root.left

    JSR binary_search        ;; recursive call to left child

    ;; pop RV
    LDR R2, R6, #0          ;; R2 = RV
    ADD R6, R6, #3          ;; popping RV and arguments

    STR R2, R5, #3          ;; RV = binarySearch(root.left, data)
    BRnzp TEARDOWN          ;; teardown binarySearch(root.left) call


;; tear down the stack
TEARDOWN

    LDR R0, R5, #-1         ;; restoring register R0
    LDR R1, R5, #-2         ;; restoring register R1
    LDR R2, R5, #-3         ;; restoring register R2
    LDR R3, R5, #-4         ;; restoring register R3
    LDR R4, R5, #-5         ;; restoring register R4
    ADD R6, R5, #0          ;; SP = FP
    LDR R5, R6, #1          ;; restoring old FP
    LDR R7, R6, #2          ;; restoring old RA
    ADD R6, R6, #3          ;; popping LV1, old FP, and old RA
    RET

STACK .fill xF000
.end

;; Assuming the tree starts at address x4000, here's how the tree (see below and in the pdf) represents in memory
;;
;;              4
;;            /   \
;;           2     8 
;;         /   \
;;        1     3 
;;
;; Memory address           Data
;; x4000                    4
;; x4001                    x4004
;; x4002                    x4008
;; x4003                    Don't Know
;; x4004                    2
;; x4005                    x400C
;; x4006                    x4010
;; x4007                    Don't Know
;; x4008                    8
;; x4009                    0(NULL)
;; x400A                    0(NULL)
;; x400B                    Don't Know
;; x400C                    1
;; x400D                    0(NULL)
;; x400E                    0(NULL)
;; x400F                    Dont't Know
;; x4010                    3
;; x4011                    0(NULL)
;; x4012                    0(NULL)
;; x4013                    Dont't Know
;;
;; *note: 0 is equivalent to NULL in assembly