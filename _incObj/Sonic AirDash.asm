; ---------------------------------------------------------------------------
; Subroutine to allow Sonic to dash in midair
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

Sonic_AirDash:
		tst.b	$3C(a0)		; is Sonic jumping?
		beq.s	.return		; if not, branch
		btst	#staAirDash,obStatus2(a0)	; has Sonic already air dashed?
		bne.s	.return		; if yes, branch
		btst	#bitA,(v_jpadpress2).w	; is A pressed?
		beq.s	.return	; if not, branch
		move.w	#$900,obVelX(a0)	; set X speed
		btst	#0,obStatus(a0)	; is Sonic facing left?
		beq.s	.launch		; if not, branch
		neg.w	obVelX(a0)	; flip X speed
	.launch:
		clr.w	obVelY(a0)	; clear Y speed
		sfx	sfx_Teleport,0,0,0	; play zoom sound
		bset	#staAirDash,obStatus2(a0)	; set air dash bit
	.return:
		rts
