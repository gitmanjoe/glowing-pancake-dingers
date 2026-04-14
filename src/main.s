.segment "HEADER"
	.byte "NES", $1A
	.byte 2       		;PRG ROM size (2 x 16KB)
	.byte 1       		;CHR ROM size (1 x 8KB)
	.byte 0,0,0,0,0,0,0,0

.segment "CODE"
.proc Reset
	sei
	cld
	lda #$00
	sta $2000		;Disable NMI
	sta $2001		;Disable rendering
	jsr wait_vblank		;Required
	jsr wait_vblank
	ldx #$FF
	txs

loop:
	jsr wait_vblank

	lda $2002		;clear PPU latch
	lda #$3F		;set PPU address to $3F00
	sta $2006
	lda #$00
	sta $2006
	lda #$27		;PPU light blue
	sta $2007

	lda #%0000100		;Enable rendering
	sta $2001

	jmp loop
.endproc

.segment "VECTORS"
	.word 0      		;NMI
	.word Reset   		;Reset
	.word 0       		;IRQ

.segment "GRAPHICS"
	.res $2000 



;-----FUNCTIONS-----
;ppu.s
.import wait_vblank
