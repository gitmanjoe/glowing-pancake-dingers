.export wait_vblank

wait_vblank:
	bit $2002
	bpl wait_vblank
	rts
