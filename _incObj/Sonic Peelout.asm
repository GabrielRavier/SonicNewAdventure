Sonic_Peelout:
		btst	#staPeelout,obStatus2(a0)
		bne.s	Sonic_PeeloutLaunch
		cmpi.b	#id_LookUp,obAnim(a0)
		bne.s	++
		move.b	(v_jpadpress2).w,d0
		andi.b	#btnABC,d0
		beq.w	++
		move.b	#id_Run,obAnim(a0)
		sfx	sfx_SpindashRev,0,0,0
		addq.l	#4,sp
		bset	#staPeelout,obStatus2(a0)
		move.b	#0,obRevSpeed(a0)
		cmpi.w	#$C,(v_air).w	; if he's drowning, branch to not make dust
		blo.s	+
		move.b	#1,(v_objspace+$1C0+obAnim).w
+
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_AnglePos
+
		rts	
; ---------------------------------------------------------------------------
 
Sonic_PeeloutLaunch:
		move.b	#id_PeeloutCharge,obAnim(a0)
		move.b	(v_jpadhold2).w,d0
		btst	#bitUp,d0
		bne.w	Sonic_PeeloutCharge
		bclr	#staPeelout,obStatus2(a0)	; stop Dashing
		cmpi.b	#$1E,obRevSpeed(a0)	; have we been charging long enough?
		bne.s	Sonic_PeeloutResetScr
		move.b	#id_Dash,obAnim(a0)	; launches here
		move.w	#1,obVelX(a0)	; force X speed to nonzero for camera lag's benefit
		move.w	#$0C00,obInertia(a0)
		move.b	obInertia(a0),d0
		subi.b	#$8,d0
		add.b	d0,d0
		andi.b	#$1F,d0
		neg.b	d0
		addi.b	#$20,d0
		move.b	d0,(v_cameralag).w
		btst	#0,obStatus(a0)
		beq.s	.dontflip
		neg.w	obInertia(a0)
 
.dontflip:
		move.b	#0,(v_objspace+$1C0+obAnim).w
		sfx	sfx_Teleport,0,0,0
		bra.w	Sonic_PeeloutResetScr
; ---------------------------------------------------------------------------
 
Sonic_PeeloutCharge:				; If still charging the dash...
		cmpi.b	#$1E,obRevSpeed(a0)
		beq.s	Sonic_PeeloutResetScr
		addi.b	#1,obRevSpeed(a0)
		
 
Sonic_PeeloutResetScr:
		addq.l	#4,sp			; increase stack ptr
		cmpi.w	#$60,(v_lookshift).w
		beq.s	.finish
		bcc.s	.skip
		addq.w	#4,(v_lookshift).w
 
	.skip:
		subq.w	#2,(v_lookshift).w
 
	.finish:
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_AnglePos
		rts
		