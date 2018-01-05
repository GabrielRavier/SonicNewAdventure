; ---------------------------------------------------------------------------
; Sprite mappings - Spindash dust
; ---------------------------------------------------------------------------
Map_Dust_internal:
		dc.w .null-Map_Dust_internal
		dc.w .f1-Map_Dust_internal
		dc.w .f1-Map_Dust_internal
		dc.w .f1-Map_Dust_internal
		dc.w .f2-Map_Dust_internal
		dc.w .f3-Map_Dust_internal
		dc.w .f4-Map_Dust_internal
		dc.w .f4-Map_Dust_internal
	
.null:	dc.b 0
.f1:	dc.b 1
		dc.b $4, $0D, $0, 0,$E0
.f2:	dc.b 2
		dc.b $F4, $01, $0, 0,$E8
		dc.b $4, $0D, $0, 2,$E0
.f3:	dc.b 2
		dc.b $F4, $05, $0, 0,$E8
		dc.b $4, $0D, $0, 4,$E0
.f4:	dc.b 2
		dc.b $F4, $09, $0, 0,$E0
		dc.b $4, $0D, $0, 6,$E0
		even