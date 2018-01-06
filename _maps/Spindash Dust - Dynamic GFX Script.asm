; ---------------------------------------------------------------------------
; Uncompressed graphics	loading	array for Spindash dust
; ---------------------------------------------------------------------------
DynPLC_Dust_internal:	
		dc.w .null-DynPLC_Dust_internal
		dc.w .dash1-DynPLC_Dust_internal
		dc.w .dash2-DynPLC_Dust_internal
		dc.w .dash3-DynPLC_Dust_internal
		dc.w .dash4-DynPLC_Dust_internal
		dc.w .dash5-DynPLC_Dust_internal
		dc.w .dash6-DynPLC_Dust_internal
		dc.w .dash7-DynPLC_Dust_internal
		
.null:	dc.w 0
.dash1:	dc.w 1
		dc.w $7000
.dash2:	dc.w 1
		dc.w $7008
.dash3:	dc.w 1
		dc.w $7010
.dash4:	dc.w 2
		dc.w $1018
		dc.w $701A
.dash5:	dc.w 2
		dc.w $3022
		dc.w $7026
.dash6:	dc.w 2
		dc.w $502E
		dc.w $7034
.dash7:	dc.w 2
		dc.w $503C
		dc.w $7042
		even