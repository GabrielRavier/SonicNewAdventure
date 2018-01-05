; ---------------------------------------------------------------------------
; Uncompressed graphics	loading	array for Spindash dust
; ---------------------------------------------------------------------------
DynPLC_Dust_internal:	
		dc.w .null-DynPLC_Dust_internal
		dc.w .f1-DynPLC_Dust_internal
		dc.w .f2-DynPLC_Dust_internal
		dc.w .f3-DynPLC_Dust_internal
		dc.w .f4-DynPLC_Dust_internal
		dc.w .f5-DynPLC_Dust_internal
		dc.w .f6-DynPLC_Dust_internal
		dc.w .f7-DynPLC_Dust_internal
		
.null:	dc 0
.f1:	dc 1
		dc.w $7000
.f2:	dc 1
		dc.w $7008
.f3:	dc 1
		dc.w $7010
.f4:	dc 2
		dc.w $1018
		dc.w $701A
.f5:	dc 2
		dc.w $3022
		dc.w $7026
.f6:	dc 2
		dc.w $502E
		dc.w $7034
.f7:	dc 2
		dc.w $503C
		dc.w $7042
		even