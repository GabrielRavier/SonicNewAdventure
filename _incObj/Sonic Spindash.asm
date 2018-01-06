; ---------------------------------------------------------------------------
; Subroutine to check for starting to charge a spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1AC3E:
Sonic_CheckSpindash:
		btst	#staSpindash,obStatus2(a0)
		bne.s	Sonic_UpdateSpindash
		cmpi.b	#id_Duck,obAnim(a0)
		bne.s	return_1AC8C
		move.b	(v_jpadpress2).w,d0
		andi.b	#btnABC,d0
		beq.w	return_1AC8C
		move.b	#id_Spindash,obAnim(a0)
		sfx	sfx_SpindashRev,0,0,0
		addq.l	#4,sp
		bset	#staSpindash,obStatus2(a0)
		move.b	#0,obRevSpeed(a0)
		cmpi.w	#$C,(v_air).w	; if he's drowning, branch to not make dust
		blo.s	+
		move.b	#1,(v_objspace+$1C0+obAnim).w
+
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_AnglePos

return_1AC8C:
		rts
; End of subroutine Sonic_CheckSpindash


; ---------------------------------------------------------------------------
; Subrouting to update an already-charging spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1AC8E:
Sonic_UpdateSpindash:
		move.b	(v_jpadhold2).w,d0
		btst	#bitDn,d0
		bne.w	Sonic_ChargingSpindash

		; unleash the charged spindash and start rolling quickly:
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#id_Roll,obAnim(a0)
		addq.w	#5,y_pos(a0)	; add the difference between Sonic's rolling and standing heights
		bclr	#staSpindash,obStatus2(a0)
		moveq	#0,d0
		move.b	obRevSpeed(a0),d0
		add.b	d0,d0
		move.w	SpindashSpeeds(pc,d0.w),obInertia(a0)
		move.b	obInertia(a0),d0
		subi.b	#$8,d0
		add.b	d0,d0
		andi.b	#$1F,d0
		neg.b	d0
		addi.b	#$20,d0
		move.b	d0,(v_cameralag).w
		btst	#0,obStatus(a0)
		beq.s	+
		neg.w	obInertia(a0)
+
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
		bra.s	Obj01_Spindash_ResetScr
; ===========================================================================
; word_1AD0C:
SpindashSpeeds:
		dc.w  $800	; 0
		dc.w  $880	; 1
		dc.w  $900	; 2
		dc.w  $980	; 3
		dc.w  $A00	; 4
		dc.w  $A80	; 5
		dc.w  $B00	; 6
		dc.w  $B80	; 7
		dc.w  $C00	; 8
; ===========================================================================
; loc_1AD30:
Sonic_ChargingSpindash:			; If still charging the dash...
		tst.b	obRevSpeed(a0)
		beq.s	+
		move.b	obRevSpeed(a0),d0
		lsr.b	#5,d0
		sub.b	d0,obRevSpeed(a0)
		bcc.s	+
		move.b	#0,obRevSpeed(a0)
+
		move.b	(v_jpadpress2).w,d0
		andi.b	#btnABC,d0
		beq.w	Obj01_Spindash_ResetScr
		move.w	#(id_Spindash<<8),obAnim(a0)
		sfx	sfx_SpindashRev,0,0,0
		addi.b	#1,obRevSpeed(a0)
		cmpi.b	#8,obRevSpeed(a0)
		blo.s	Obj01_Spindash_ResetScr
		move.b	#8,obRevSpeed(a0)

; loc_1AD78:
Obj01_Spindash_ResetScr:
		addq.l	#4,sp
		cmpi.w	#(224/2)-16,(v_lookshift).w
		beq.s	loc_1AD8C
		bhs.s	+
		addq.w	#4,(v_lookshift).w
+		subq.w	#2,(v_lookshift).w

loc_1AD8C:
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_AnglePos
		rts
; End of subroutine Sonic_UpdateSpindash