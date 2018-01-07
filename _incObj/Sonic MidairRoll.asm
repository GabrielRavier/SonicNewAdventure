; ---------------------------------------------------------------------------
; Subroutine to	allow Sonic to roll in midair
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Sonic_MidairRoll:
		btst	#2,obStatus(a0)	; is Sonic already rolling?
		bne.s	.return		; if yes, branch
		btst	#bitDn,(v_jpadpress2).w	; is down pressed?
		beq.s	.return		; if not, branch
		sfx	sfx_Roll,0,0,0	; play rolling sound
		move.b	#$E,obHeight(a0)
		move.b	#7,obWidth(a0)
		move.b	#id_Roll,obAnim(a0)	; use "rolling" animation
		bset	#2,obStatus(a0)
		addq.w	#5,obY(a0)

	.return:
		rts

; ---------------------------------------------------------------------------
; Subroutine to	allow Sonic to unroll in midair
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Sonic_MidairUnroll:
		btst	#2,obStatus(a0)	; is Sonic rolling?
		beq.s	.return		; if not, branch
		btst	#bitUp,(v_jpadpress2).w	; is up pressed?
		beq.s	.return		; if not, branch
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)
		move.b	#id_Run,obAnim(a0)	; use running animation
		bclr	#2,obStatus(a0)
		subq.w	#5,obY(a0)
		bclr	#staDropDash,obStatus2(a0)	; clear drop dash bit

	.return:
		rts
