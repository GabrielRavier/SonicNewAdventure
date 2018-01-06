; ---------------------------------------------------------------------------
; Animation script - Spindash dust
; ---------------------------------------------------------------------------
Ani_Dust:
		dc.w .null-Ani_Dust
		dc.w .dash-Ani_Dust
		dc.w .dash2-Ani_Dust
		
.null:	dc.b	$1F, 0, afEnd
.dash:	dc.b	1, 1, 2, 3, 4, 5, 6, 7, afEnd
.dash2:	dc.b	0, 1, 2, 3, 4, 5, 6, 7, afEnd
		even