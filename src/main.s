.segment "HEADER"
    .byte "NES", $1A
    .byte 2       ; PRG ROM size (2 x 16KB)
    .byte 1       ; CHR ROM size (1 x 8KB)
    .byte 0,0,0,0,0,0,0,0

.segment "PROGRAM"
.proc Reset
    sei
    cld
    ldx #$FF
    txs

loop:
    jmp loop
.endproc

.segment "VECTORS"
    .word 0       ; NMI
    .word Reset   ; Reset
    .word 0       ; IRQ

.segment "GRAPHICS"
    .res $2000 
