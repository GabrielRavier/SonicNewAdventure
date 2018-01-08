; ---------------------------------------------------------------------------
; Subroutine to	set Sonic's animation in the air
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Sonic_SetAnimAir:
		cmpi.b	#2,obRoutine(a0)	; is Sonic in his standard routine?
		bne.s	.return				; if not, branch
		btst	#1,obStatus(a0)	; is Sonic in the air?
		beq.s	.runanim		; if not, branch
		btst	#2,obStatus(a0)	; is Sonic rolling?
		bne.s	.return		; if yes, branch
		move.w	obVelX(a0),d0
		tst.w	d0
		bge.s	.gotvelx
		neg.w	d0
	.gotvelx:
		cmpi.w	#$A00,d0	; is Sonic moving fast?
		bge.s	.runanim	; if yes, branch
		tst.w	obVelY(a0)	; is Sonic going down?
		bgt.s	.goingdown	; if yes, branch
		; so, we're going up then
		move.b	#id_Spring,obAnim(a0)	; use spring animation
		rts
	.goingdown:
		move.b	#id_Fall2,obAnim(a0)	; use falling animation
		move.w	obVelY(a0),d0
		tst.w	d0
		bge.s	.gotvely
		neg.w	d0
	.gotvely:
		cmpi.w	#$A00,d0	; is Sonic falling fast?
		bge.s	.return		; if yes, branch
		move.b	#id_Fall,obAnim(a0)		; use slower falling animation
		rts
	.runanim:
		move.b	#id_Run,obAnim(a0)	; use running animation
	.return:
		rts
