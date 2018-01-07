; ---------------------------------------------------------------------------
; Subroutine to allow Sonic to perform the Drop Dash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

Sonic_DropDash:
		tst.b	$3C(a0)		; is Sonic jumping?
		beq.s	.return		; if not, branch
		btst	#bitB,(v_jpadhold2).w	; is B held?
		beq.s	.return	; if not, branch
		btst	#staDropDash,obStatus2(a0)	; is a Drop Dash already charged?
		bne.s	.start		; if yes, branch
		move.b	#0,obRevSpeed(a0)	; clear rev speed
		bset	#staDropDash,obStatus2(a0)	; set drop dash bit
	.start:
		cmpi.b	#$1E,obRevSpeed(a0)	; charged up to max?
		bge.s	.return		; if yes, branch
		addq.b	#1,obRevSpeed(a0)	; increase rev speed
		cmpi.b	#$E,obRevSpeed(a0)	; are we charged up enough?
		bne.s	.return		; if not, branch
		sfx	sfx_SpindashRev,0,0,0	; play charge sound
	.return:
		rts

; ---------------------------------------------------------------------------
; Subroutine to release a charged Drop Dash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

Sonic_DropDashRelease:
		btst	#staDropDash,obStatus2(a0)	; is a Drop Dash charged?
		beq.w	.return		; if not, branch
		bclr	#staDropDash,obStatus2(a0)	; stop the Drop Dash
		cmpi.b	#$E,obRevSpeed(a0)	; are we charged up enough?
		blt.s	.return		; if not, branch
		
		; unleash the charged drop dash and start rolling quickly:
		btst	#2,obStatus(a0)
		bne.s	.alreadyrolling
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		addq.w	#5,y_pos(a0)	; add the difference between Sonic's rolling and standing heights
	.alreadyrolling:
		move.b	#id_Roll,obAnim(a0)
		moveq	#0,d0
		move.b	obRevSpeed(a0),d0
		sub.b	#$E,d0
		lsr.b	#1,d0
		add.b	d0,d0
		lea	(SpindashSpeeds).l,a1
		move.w	(a1,d0.w),obInertia(a0)
		btst	#0,obStatus(a0)
		beq.s	.launch
		neg.w	obInertia(a0)
	.launch:
		bset	#2,obStatus(a0)
		move.b	#0,(v_objspace+$1C0+obAnim).w
		sfx	sfx_Teleport,0,0,0				; spindash zoom sound
		move.b	obAngle(a0),d0
		jsr	(CalcSine).l
		muls.w	obInertia(a0),d1
		asr.l	#8,d1
		move.w	d1,obVelX(a0)
		muls.w	obInertia(a0),d0
		asr.l	#8,d0
		move.w	d0,obVelY(a0)
	.return:
		rts
