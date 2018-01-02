; ---------------------------------------------------------------------------
; Subroutine to	pause the game
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PauseGame:
		nop	
		tst.b	(v_lives).w	; do you have any lives	left?
		beq.s	Unpause		; if not, branch
		tst.w	(f_pause).w	; is game already paused?
		bne.s	Pause_StopGame	; if yes, branch
		btst	#bitStart,(v_jpadpress1).w ; is Start button pressed?
		beq.s	Pause_DoNothing	; if not, branch

Pause_StopGame:
		move.w	#1,(f_pause).w	; freeze time
		SMPS_PauseMusic ; pause music

Pause_Loop:
		move.b	#$10,(v_vbla_routine).w
		bsr.w	WaitForVBla
		moveq	#0,d0
		tst.b	(f_levselcheat).w ; check if level select code is on
		beq.s	.notlevsel		; if not, branch
		move.b	#id_LevSel,d0	; to level select
		bra.s	.checka
	.notlevsel:
		tst.b	(f_slomocheat).w ; is slow-motion cheat on?
		beq.s	Pause_ChkStart	; if not, branch
		move.b	#id_Title,d0	; to title screen
	.checka:
		btst	#bitA,(v_jpadpress1).w ; is button A pressed?
		beq.s	Pause_ChkBC	; if not, branch
		move.b	d0,(v_gamemode).w ; set game mode to title screen/level select
		nop	
		bra.s	Pause_EndMusic
; ===========================================================================

Pause_ChkBC:
		btst	#bitB,(v_jpadhold1).w ; is button B pressed?
		bne.s	Pause_SlowMo	; if yes, branch
		btst	#bitC,(v_jpadpress1).w ; is button C pressed?
		bne.s	Pause_SlowMo	; if yes, branch

Pause_ChkStart:
		btst	#bitStart,(v_jpadpress1).w ; is Start button pressed?
		beq.s	Pause_Loop	; if not, branch

Pause_EndMusic:
		SMPS_UnpauseMusic

Unpause:
		move.w	#0,(f_pause).w	; unpause the game

Pause_DoNothing:
		rts	
; ===========================================================================

Pause_SlowMo:
		move.w	#1,(f_pause).w
		SMPS_UnpauseMusic
		rts	
; End of function PauseGame
