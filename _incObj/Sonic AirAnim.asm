; ---------------------------------------------------------------------------
; Subroutine to	animate Sonic in the air
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Sonic_AirAnim:
		btst	#2,obStatus(a0)	; is Sonic rolling?
		bne.s	.return		; if yes, branch
		tst.w	obVelY(a0)	; is Sonic going up?
		ble.s	.goingup	; if yes, branch
		; so, we're going down then
		move.b	#id_Fall2,obAnim(a0)	; use falling animation
		cmpi.w	#$600,obVelY(a0)	; is Sonic falling fast?
		bcc.s	.return		; if yes, branch
		move.b	#id_Fall,obAnim(a0)		; use slower falling animation
		rts
	.goingup:
		move.b	#id_Spring,obAnim(a0)	; use spring animation
	.return:
		rts
