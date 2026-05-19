; Option B: Test Score Calculator
; LC-3 version 05/15/2026
; Coded By Luis Arellano, Micheal Babeshkov.

        .ORIG x3000

        LD   R6, STACKTOP     ; start stack

        LEA  R0, TITLE
        TRAP x22              ; print title
        LEA  R0, NL
        TRAP x22

; Read 5 scores into the array.
        LEA  R1, SCORES       ; pointer to array
        AND  R2, R2, #0
        ADD  R2, R2, #5       ; counter = 5

INPUT   LEA  R0, PROMPT
        TRAP x22
        JSR  READ2            ; get two-digit score
        STR  R0, R1, #0       ; store score
        ADD  R1, R1, #1       ; next array spot
        ADD  R2, R2, #-1
        BRp  INPUT

; Find max, min, and sum.
        LEA  R1, SCORES
        AND  R2, R2, #0
        ADD  R2, R2, #5
        AND  R3, R3, #0       ; sum
        LD   R4, BIG          ; min starts high
        AND  R5, R5, #0       ; max starts low

LOOP    LDR  R0, R1, #0       ; current score
        ADD  R3, R3, R0       ; add to sum

        NOT  R7, R4           ; compare score and min
        ADD  R7, R7, #1
        ADD  R7, R0, R7
        BRzp NOMIN
        ADD  R4, R0, #0
NOMIN

        NOT  R7, R5           ; compare score and max
        ADD  R7, R7, #1
        ADD  R7, R0, R7
        BRnz NOMAX
        ADD  R5, R0, #0
NOMAX

        ADD  R1, R1, #1
        ADD  R2, R2, #-1
        BRp  LOOP

        ST   R4, MIN
        ST   R5, MAX
        ADD  R0, R3, #0
        JSR  DIV5             ; average = sum / 5
        ST   R0, AVG

; Print answers.
        LEA  R0, NL
        TRAP x22

        LEA  R0, MAXMSG
        TRAP x22
        LD   R0, MAX
        JSR  PRINT2
        LD   R0, MAX
        JSR  GRADE

        LEA  R0, MINMSG
        TRAP x22
        LD   R0, MIN
        JSR  PRINT2
        LD   R0, MIN
        JSR  GRADE

        LEA  R0, AVGMSG
        TRAP x22
        LD   R0, AVG
        JSR  PRINT2
        LD   R0, AVG
        JSR  GRADE

        TRAP x25              ; stop program

; Data.
TITLE    .STRINGZ "Test Score Calculator"
PROMPT   .STRINGZ "Score: "
MAXMSG   .STRINGZ "Max: "
MINMSG   .STRINGZ "Min: "
AVGMSG   .STRINGZ "Avg: "
SPACE    .STRINGZ " "
NL       .FILL x000A
         .FILL x0000

ASCII0   .FILL x0030
NEG0     .FILL xFFD0
NEG60    .FILL #-60
NEG70    .FILL #-70
NEG80    .FILL #-80
NEG90    .FILL #-90
BIG      .FILL #100
STACKTOP .FILL x4000

SCORES   .BLKW #5
MIN      .BLKW #1
MAX      .BLKW #1
AVG      .BLKW #1

; READ2 reads a two-digit score and returns it in R0.
READ2   ADD  R6, R6, #-1      ; push R7
        STR  R7, R6, #0
        ADD  R6, R6, #-1      ; push R1
        STR  R1, R6, #0
        ADD  R6, R6, #-1      ; push R2
        STR  R2, R6, #0

        TRAP x20              ; read tens digit
        TRAP x21              ; echo
        LD   R1, NEG0
        ADD  R1, R0, R1       ; tens value

        ADD  R2, R1, R1       ; tens * 10
        ADD  R2, R2, R2
        ADD  R2, R2, R2
        ADD  R2, R2, R1
        ADD  R2, R2, R1

        TRAP x20              ; read ones digit
        TRAP x21              ; echo
        LD   R1, NEG0
        ADD  R1, R0, R1       ; ones value
        ADD  R0, R2, R1       ; final score

        LEA  R1, NL
        ADD  R2, R0, #0
        ADD  R0, R1, #0
        TRAP x22
        ADD  R0, R2, #0

        LDR  R2, R6, #0       ; pop R2
        ADD  R6, R6, #1
        LDR  R1, R6, #0       ; pop R1
        ADD  R6, R6, #1
        LDR  R7, R6, #0       ; pop R7
        ADD  R6, R6, #1
        RET

; DIV5 divides R0 by 5 and returns the answer in R0.
DIV5    ADD  R6, R6, #-1
        STR  R7, R6, #0
        AND  R1, R1, #0       ; answer
DLOOP   ADD  R0, R0, #-5
        BRn  DDONE
        ADD  R1, R1, #1
        BR   DLOOP
DDONE   ADD  R0, R1, #0
        LDR  R7, R6, #0
        ADD  R6, R6, #1
        RET

; PRINT2 prints R0 as two digits.
PRINT2  ADD  R6, R6, #-1
        STR  R7, R6, #0
        AND  R1, R1, #0       ; tens count
PLOOP   ADD  R0, R0, #-10
        BRn  PDONE
        ADD  R1, R1, #1
        BR   PLOOP
PDONE   ADD  R0, R0, #10      ; ones value
        ADD  R2, R0, #0
        LD   R0, ASCII0
        ADD  R0, R0, R1
        TRAP x21              ; print tens
        LD   R0, ASCII0
        ADD  R0, R0, R2
        TRAP x21              ; print ones
        LEA  R0, SPACE
        TRAP x22
        LDR  R7, R6, #0
        ADD  R6, R6, #1
        RET

; GRADE prints the letter grade for R0.
GRADE   ADD  R6, R6, #-1
        STR  R7, R6, #0
        LD   R1, NEG90
        ADD  R1, R0, R1
        BRzp A
        LD   R1, NEG80
        ADD  R1, R0, R1
        BRzp B
        LD   R1, NEG70
        ADD  R1, R0, R1
        BRzp C
        LD   R1, NEG60
        ADD  R1, R0, R1
        BRzp D
        LD   R0, ASCIIF
        BR   SHOW
A       LD   R0, ASCIIA
        BR   SHOW
B       LD   R0, ASCIIB
        BR   SHOW
C       LD   R0, ASCIIC
        BR   SHOW
D       LD   R0, ASCIID
SHOW    TRAP x21
        LEA  R0, NL
        TRAP x22
        LDR  R7, R6, #0
        ADD  R6, R6, #1
        RET

ASCIIA   .FILL x0041
ASCIIB   .FILL x0042
ASCIIC   .FILL x0043
ASCIID   .FILL x0044
ASCIIF   .FILL x0046

        .END
