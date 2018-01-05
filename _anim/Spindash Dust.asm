; ---------------------------------------------------------------------------
; Animation script - Spindash dust
; ---------------------------------------------------------------------------
Ani_Dust:
		dc.w .null-Ani_Dust
		dc.w .active-Ani_Dust
		
.null:	dc.b	$1F, 0, afEnd
.active:	dc.b	1, 1, 2, 3, 4, 5, 6, 7, afEnd
		even