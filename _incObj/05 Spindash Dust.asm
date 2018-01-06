; ----------------------------------------------------------------------------
; Object 05 - Spindash dust
; ----------------------------------------------------------------------------
SpindashDust:
		moveq	#0,d0
		move.b	obRoutine(a0),d0 
		move.w	Dust_Index(pc,d0.w),d1
		jmp	Dust_Index(pc,d1.w)
; ===========================================================================
Dust_Index:
		dc.w Dust_Init-Dust_Index
		dc.w Dust_Main-Dust_Index
; ===========================================================================
Dust_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Dust,obMap(a0)
		ori.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#$10,obActWid(a0)
		move.b	#0,obAnim(a0)
		move.w	#$7A0,obGfx(a0)
		move.w	#$F400,$3C(a0)
; ===========================================================================
Dust_Main:
		tst.w	(v_debuguse).w	; is debug mode being used?
		bne.w	.return		; if yes, branch
		cmpi.b	#2,(v_player+obRoutine).w		; is Sonic in routine 2 (normal control routine)?
		bne.w	.return		; if not, branch
		moveq	#0,d0
		btst	#staSpindash,(v_player+obStatus2).w		; is Sonic spindashing?
		bne.s	.spindash		; if yes, branch
		btst	#staPeelout,(v_player+obStatus2).w	; is Sonic peeling out?
		beq.s	.return		; if not, branch
		cmpi.b	#$1E,(v_player+obRevSpeed).w	; is Sonic charged up?
		bne.s	.return		; if not, branch
		move.w	#8,d0	; set X offset to 0
		btst	#0,(v_player+obStatus).w	; is Sonic facing left?
		beq.s	.active	; if not, branch
		neg.w	d0		; flip X offset
		bra.s	.active

	.spindash:
		move.b	#2,obAnim(a0)	; use faster animation
		cmpi.b	#8,(v_player+obRevSpeed).w		; is Sonic fully charged?
		beq.s	.active		; if yes, branch
		move.b	#1,obAnim(a0)	; use slower animation

	.active:
		lea	(v_player).l,a2
		move.w	obX(a2),obX(a0)		; match Sonic's position
		add.w	d0,obX(a0)		; offset our X position
		move.w	obY(a2),obY(a0)
		move.b	obStatus(a2),obStatus(a0)	; match Sonic's X orientation
		bclr	#0,obRender(a0)
		andi.b	#1,obStatus(a0)
		beq.s	.display
		bset	#0,obRender(a0)

	.display:
		lea	(Ani_Dust).l,a1
		jsr	AnimateSprite
		bsr.s	Dust_LoadArt
		jmp	DisplaySprite

	.return:
		rts
; ===========================================================================
Dust_LoadArt:
		moveq	#0,d0
		move.b	obFrame(a0),d0
		cmp.b	$30(a0),d0
		beq.s	return_1DF36
		move.b	d0,$30(a0)
		lea	(DynPLC_Dust).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	return_1DF36
		move.w	$3C(a0),d4

	.loop:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		addi.l	#Art_Dust,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(QueueDMATransfer).l
		dbf	d5,.loop

	return_1DF36:
		rts
; ===========================================================================
		include "_anim/Spindash Dust.asm"
Map_Dust:	include "_maps/Spindash Dust.asm"
DynPLC_Dust:	include "_maps/Spindash Dust - Dynamic GFX Script.asm"