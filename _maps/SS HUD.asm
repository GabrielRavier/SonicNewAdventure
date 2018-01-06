; ---------------------------------------------------------------------------
; Sprite mappings - SCORE, TIME, RINGS
; ---------------------------------------------------------------------------
Map_SS_HUD_internal:
		dc.w .allyellow-Map_SS_HUD_internal, .ringgone-Map_SS_HUD_internal
		dc.w .timegone-Map_SS_HUD_internal, .bothgone-Map_SS_HUD_internal

.allyellow:	dc.b $B
		dc.b $80, $D, $80, $10, 0	; SCOR
		dc.b $80, $D, $80, $28,	$20	; E nnn
		dc.b $80, $D, $80, $30,	$40	; nnnn
		dc.b $90, $D, $80, $20,	0	; TIME
		dc.b $90, $D, $80, $38,	$28	; n'nn
			dc.b $90, 9, $80, $0,	$48	; "nn
		dc.b $A0, $D, $80, $18, 0	; RING
		dc.b $A0, 1, $80, $10, $20	; S
		dc.b $A0, 9, $80, $40, $30	; rings
		dc.b $40, 5, $80, $46, 0	; icon
		dc.b $40, $D, $80, $4A, $10	; SONIC x nn
		dc.b 0
.ringgone:	dc.b $9
		dc.b $80, $D, $80, $10, 0	; SCOR
		dc.b $80, $D, $80, $28,	$20	; E nnn
		dc.b $80, $D, $80, $30,	$40	; nnnn
		dc.b $90, $D, $80, $20,	0	; TIME
		dc.b $90, $D, $80, $38,	$28	; n'nn
			dc.b $90, 9, $80, $0,	$48	; "nn
		dc.b $A0, 9, $80, $40, $30	; rings
		dc.b $40, 5, $80, $46, 0	; icon
		dc.b $40, $D, $80, $4A, $10	; SONIC x nn
		dc.b 0
.timegone:	dc.b $A
		dc.b $80, $D, $80, $10, 0	; SCOR
		dc.b $80, $D, $80, $28,	$20	; E nnn
		dc.b $80, $D, $80, $30,	$40	; nnnn
		dc.b $90, $D, $80, $38,	$28	; n'nn
			dc.b $90, 9, $80, $0,	$48	; "nn
		dc.b $A0, $D, $80, $18, 0	; RING
		dc.b $A0, 1, $80, $10, $20	; S
		dc.b $A0, 9, $80, $40, $30	; rings
		dc.b $40, 5, $80, $46, 0	; icon
		dc.b $40, $D, $80, $4A, $10	; SONIC x nn
		dc.b 0
.bothgone:	dc.b $8
		dc.b $80, $D, $80, $10, 0	; SCOR
		dc.b $80, $D, $80, $28,	$20	; E nnn
		dc.b $80, $D, $80, $30,	$40	; nnnn
		dc.b $90, $D, $80, $38,	$28	; n'nn
			dc.b $90, 9, $80, $0,	$48	; "nn
		dc.b $A0, 9, $80, $40, $30	; rings
		dc.b $40, 5, $80, $46, 0	; icon
		dc.b $40, $D, $80, $4A, $10	; SONIC x nn
		even
		