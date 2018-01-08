; ---------------------------------------------------------------------------
; Subroutine to	set Sonic's animation in the air
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Sonic_SetAnimAir:
		cmpi.b	#2,obRoutine(a0)	; is Sonic in his standard routine?
		bne.s	.return				; if not, branch
		btst	#1,obStatus(a0)	; is Sonic in the air?
		beq.s	.standanim		; if not, branch
		btst	#3,obStatus(a0)	; is Sonic standing on an object?
		bne.s	.standanim		; if not, branch
		btst	#2,obStatus(a0)	; is Sonic rolling?
		bne.s	.return		; if yes, branch
		cmpi.b	#id_GetAir,obAnim(a0)	; is Sonic in the air bubble animation?
		beq.s	.return		; if yes, branch
		move.w	obVelX(a0),d0
		tst.w	d0
		bge.s	.gotvelx
		neg.w	d0
	.gotvelx:
		cmpi.w	#$A00,d0	; is Sonic moving fast?
		bge.s	.walkanim	; if yes, branch
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
		cmpi.w	#$800,d0	; is Sonic falling fast?
		bge.s	.return		; if yes, branch
		move.b	#id_Fall,obAnim(a0)		; use slower falling animation
		rts
	.standanim:
		move.b	#id_Wait,obAnim(a0)	; use waiting animation
		tst.w	obInertia(a0)		; is Sonic moving?
		beq.s	.return			; if not, branch
	.walkanim:
		move.b	#id_Walk,obAnim(a0)	; use running animation
	.return:
		rts
