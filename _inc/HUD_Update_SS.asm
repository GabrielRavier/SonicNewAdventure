; ---------------------------------------------------------------------------
; Subroutine to	update the HUD in the Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


HUD_Update_SS:
		lea	($C00000).l,a6
		tst.w	(v_debuguse).w	; is debug mode	on?
		bne.w	HudDebug_SS	; if yes, branch
		tst.b	(f_debughud).w
		beq.s	.proceed
		bsr.w	Hud_Base_SS
		move.b	#1,(f_scorecount).w
		move.b	#1,(f_ringcount).w
	.proceed:
		tst.b	(f_scorecount).w ; does the score need updating?
		beq.s	.chkrings	; if not, branch
		clr.b	(f_scorecount).w
		hudVRAM	$4260		
		move.l	(v_score).w,d1	; load score
		bsr.w	Hud_Score

	.chkrings:
		tst.b	(f_ringcount).w	; does the ring	counter	need updating?
		beq.s	.chktime	; if not, branch
		bpl.s	.dorings
		bsr.w	Hud_LoadZero_SS

	.dorings:
		clr.b	(f_ringcount).w
		hudVRAM	$4520
		moveq	#0,d1
		move.w	(v_rings).w,d1	; load number of rings
		bsr.w	Hud_Rings

	.chktime:
		tst.b	(f_timecount).w	; does the time	need updating?
		beq.w	.chklives	; if not, branch
		tst.w	(f_pause).w	; is the game paused?
		bne.w	.chklives	; if yes, branch
		lea	(v_time).w,a1
		cmpi.l	#$93B63,(a1)+	; is the time 9'59"99?
		beq.w	TimeOver_SS	; if yes, branch
		move.b	(v_centstep).w,d1
		addi.b	#1,d1
		cmpi.b	#3,d1
		bne.s	.skip
		move.b	#0,d1
		
	.skip:
		move.b	d1,(v_centstep).w
		cmpi.b	#2,d1
		beq.s	.skip2
		addi.b	#1,d1
		
	.skip2:
		add.b	d1,-(a1)
		cmpi.b	#100,(a1)
		bcs.s	.debugupdate
		move.b	#0,(a1)		; clear jiffy
		addq.b	#1,-(a1)	; inc sec
		cmpi.b	#60,(a1)	; if 60
		bcs.s	.dotime
		move.b	#0,(a1)		; clear sec
		addq.b	#1,-(a1)	; inc min
		cmpi.b	#9,(a1)		; if 9
		bcs.s	.dotime
		move.b	#9,(a1)		; set min to 9
		
	.debugupdate:
		tst.b	(f_debughud).w
		beq.s	.docent
		clr.b	(f_debughud).w

	.dotime:
		hudVRAM	$4420
		moveq	#0,d1
		move.b	(v_timemin).w,d1 ; load	minutes
		bsr.w	Hud_Mins
		hudVRAM	$44A0
		moveq	#0,d1
		move.b	(v_timesec).w,d1 ; load	seconds
		bsr.w	Hud_Secs
	.docent:
		hudVRAM	$3D60
		moveq	#0,d1
		move.b	(v_timecent).w,d1 ; load centiseconds
		bsr.w	Hud_Secs
		

	.chklives:
		tst.b	(f_lifecount).w ; does the lives counter need updating?
		beq.s	.return		; if not, branch
		clr.b	(f_lifecount).w
		bsr.w	Hud_Lives_SS
		
	.return:
		rts	
; ===========================================================================

TimeOver_SS:				; XREF: HUD_Update_SS.chktime
		clr.b	(f_timecount).w	; stop the time counter
		rts	
; ===========================================================================

HudDebug_SS:				; XREF: HUD_Update_SS
		move.b	#1,(f_debughud).w
		bsr.w	HudDb_XY_SS
		tst.b	(f_ringcount).w	; does the ring	counter	need updating?
		beq.s	HudDb_ObjCount_SS	; if not, branch
		bpl.s	HudDb_Rings_SS
		bsr.w	Hud_LoadZero_SS

HudDb_Rings_SS:
		clr.b	(f_ringcount).w
		hudVRAM	$4520	
		moveq	#0,d1
		move.w	(v_rings).w,d1	; load number of rings
		bsr.w	Hud_Rings

HudDb_ObjCount_SS:
		hudVRAM	$44A0
		moveq	#0,d1
		move.b	(v_spritecount).w,d1 ; load "number of objects" counter
		bsr.w	Hud_Secs
		tst.b	(f_lifecount).w ; does the lives counter need updating?
		beq.s	.return		; if not, branch
		clr.b	(f_lifecount).w
		bsr.w	Hud_Lives_SS

	.return:
		rts	
; End of function HUD_Update_SS

; ---------------------------------------------------------------------------
; Subroutine to	load "0" on the	HUD in the Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hud_LoadZero_SS:				; XREF: HUD_Update_SS
		locVRAM	$4520
		lea	Hud_TilesZero(pc),a2
		move.w	#2,d2
		bra.w	loc_1C83E
; End of function Hud_LoadZero_SS

; ---------------------------------------------------------------------------
; Subroutine to	load " on the	HUD in the Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hud_LoadMarks_SS:				; XREF: HUD_Update_SS
		locVRAM	$3D20
		lea	Hud_TilesMarks(pc),a2
		move.w	#2,d2
		bra.w	loc_1C83E
; End of function Hud_LoadMarks_SS

; ---------------------------------------------------------------------------
; Subroutine to	load uncompressed HUD patterns ("E", "0", colon) in Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hud_Base_SS:				; XREF: GM_Special
		lea	($C00000).l,a6
		bsr.w	Hud_Lives_SS
		bsr.s	Hud_LoadMarks_SS
		locVRAM	$4220	;Mercury Macros
		lea	Hud_TilesBase(pc),a2
		move.w	#$E,d2
		bra.w	loc_1C83E
; End of function Hud_Base_SS

; ---------------------------------------------------------------------------
; Subroutine to	load debug mode	numbers	patterns in Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


HudDb_XY_SS:				; XREF: HudDebug_SS
		locVRAM	$4220	;Mercury Macros
		move.w	(v_screenposx).w,d1 ; load camera x-position
		swap	d1
		move.w	(v_player+obX).w,d1 ; load Sonic's x-position
		bsr.w	HudDb_XY2
		move.w	(v_screenposy).w,d1 ; load camera y-position
		swap	d1
		move.w	(v_player+obY).w,d1 ; load Sonic's y-position
		bra.w	HudDb_XY2
		;rts
; End of function HudDb_XY_SS

; ---------------------------------------------------------------------------
; Subroutine to	load uncompressed lives	counter	patterns in Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hud_Lives_SS:				; XREF: .chklives
		hudVRAM	$4700	;Mercury Macros
		moveq	#0,d1
		move.b	(v_lives).w,d1	; load number of lives
		lea	(Hud_10).l,a2
		moveq	#1,d6
		moveq	#0,d4
		lea	Art_LivesNums(pc),a1
		bra.w	Hud_LivesLoop
		;rts
; End of function Hud_Lives_SS