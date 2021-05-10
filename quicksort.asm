data_seg segment
    A DW 3,1,4,2,5,7,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50
    B DW 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
data_seg ends

stack_seg segment stack
    ST DB 100 DUP(0)
    TOP　EQU 1000   ;这个地方top的设置不同会导致奇怪的错误，好像会把codeseg上的东西改掉
stack_seg ends

code_seg segment
    assume cs:code_seg,ds:data_seg,ss:stack_seg
start:
    MOV AX,data_seg
    MOV DS,AX
    MOV AX,stack_seg
    MOV SS,AX
    MOV SP,TOP
    
    PUSH 0
    PUSH 49
    CALL quicksort
    INT 21H
quicksort proc near
PUSH BP
MOV BP,SP
MOV AX,SS:[BP+6]    ;AX=left
MOV BX,SS:[BP+4]    ;BX=right
CMP AX,BX           ;if(left>=right)    return;
JGE quit

CMP BX,51
JG quit

MOV SI,AX
SHL SI,1            ;SI对应偏移量，要在下标基础上*2
MOV CX,[SI]       ;k=a[left]
do_while:

    while1:
    MOV SI,BX
    SHL SI,1
    CMP [SI],CX     ;if(a[r]<k)
    JL  out1
    CMP BX,AX       ;if(r>l)
    JLE out1
    DEC BX          ;r--
    JMP while1

    out1:
    MOV SI,AX
    MOV DI,BX
    SHL SI,1
    SHL DI,1
    MOV DI,[DI]
    MOV [SI],DI     ;a[l]=a[r]

    while2:
    MOV SI,AX
    SHL SI,1
    CMP [SI],CX     ;if(a[l]>k)
    JG  out2
    CMP AX,BX       ;l>=r
    JGE out2
    INC AX
    JMP while2

    out2:
    MOV SI,BX
    MOV DI,AX
    SHL SI,1
    SHL DI,1
    MOV DI,[DI]
    MOV [SI],DI

    CMP AX,BX
JL  do_while

MOV SI,AX
SHL SI,1
MOV [SI],CX

PUSH BP
PUSH SS:[BP+6]  ;left
MOV SI,BX
DEC SI
PUSH SI
CALL quicksort
POP SI
POP SI
POP BP

PUSH BP
MOV SI,AX
INC SI
PUSH SI
PUSH SS:[BP+4]  ;right
CALL quicksort
POP SI
POP SI
POP BP

quit:
POP BP
RET
quicksort endp
code_seg ends
end start