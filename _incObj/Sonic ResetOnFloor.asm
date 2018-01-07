; ---------------------------------------------------------------------------
; Subroutine to	reset Sonic's mode when he lands on the floor
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_ResetOnFloor:
		btst	#4,obStatus(a0)
		beq.s	loc_137AE
		nop	
		nop	
		nop	

loc_137AE:
		bclr	#5,obStatus(a0)
		bclr	#1,obStatus(a0)
		bclr	#4,obStatus(a0)
		btst	#2,obStatus(a0)
		beq.s	loc_137E4
		cmpa.l	a0,a1			; if a0 and a1 are the same, we're being called from SolidObject...
		beq.s	.fromsolidobj	; ...so we're going to skip the call to Sonic_DropDashRelease
		btst	#staDropDash,obStatus2(a0)
		beq.s	.fromsolidobj
		bsr.w	Sonic_DropDashRelease
		bra.s	loc_137E4
	.fromsolidobj:
		bclr	#staDropDash,obStatus2(a0)
		bclr	#2,obStatus(a0)
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)
		move.b	#id_Walk,obAnim(a0) ; use running/walking animation
		subq.w	#5,obY(a0)

loc_137E4:
		move.b	#0,$3C(a0)
		move.w	#0,(v_itembonus).w
		rts	
; End of function Sonic_ResetOnFloor