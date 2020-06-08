; =============================================================================
; Top-level
; =============================================================================
; AS configuration and original binary file to patch over
	CPU 68000
	PADDING OFF
	ORG		$000000
	BINCLUDE	"prg.orig"

; Free space to put new routines.
ROM_FREE	=	$3A566 ; Not really free, but overwriting error strings

; A little bit of unused RAM.
;RAM_FREE	=	??????
;	ORG RAM_FREE
;LAST_RAM	:=	*
	ORG ROM_FREE
LAST_ROM	:=	*

	INCLUDE		"src/vars.s"

	INCLUDE		"src/freeplay.s"
	
	ORG	$23340
	; 2ee46
	; 2edf6
	; 2ee12
