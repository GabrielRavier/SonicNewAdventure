; ---------------------------------------------------------------------------
; Sprite mappings - Spindash dust
; ---------------------------------------------------------------------------
Map_Dust_internal:
		dc.w .null-Map_Dust_internal
		dc.w .dash1-Map_Dust_internal
		dc.w .dash1-Map_Dust_internal
		dc.w .dash1-Map_Dust_internal
		dc.w .dash2-Map_Dust_internal
		dc.w .dash3-Map_Dust_internal
		dc.w .dash4-Map_Dust_internal
		dc.w .dash4-Map_Dust_internal
	
.null:	dc.b 0
.dash1:	dc.b 1
		dc.b $4, $0D, $0, 0, $E0
.dash2:	dc.b 2
		dc.b $F4, $01, $0, 0, $E8
		dc.b $4, $0D, $0, 2, $E0
.dash3:	dc.b 2
		dc.b $F4, $05, $0, 0, $E8
		dc.b $4, $0D, $0, 4, $E0
.dash4:	dc.b 2
		dc.b $F4, $09, $0, 0, $E0
		dc.b $4, $0D, $0, 6, $E0
		even