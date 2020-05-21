; Macro for checking free play ----------------------------
FREEPLAY macro
	btst	#0, (DipSw).l
	beq	+
	ENDM

; Fudge the credit check during the demo
	ORG	$02EED4
	jsr	(demo_credit_bypass).l

; And on the title
	ORG	$0055D6
	jmp	(title_credit_bypass).l

; Finally, the story
	ORG	$02C210
	jmp	(story_credit_bypass).l

; Remove coin cost in free play.
	ORG	$024A1A
	jmp	(credit_update_bypass).l

; Don't print the credit count in free play
	ORG	$24A48
	jmp	(credit_update_draw_bypass).l

; -----------------------------------------------------------------------------
	ORG	LAST_ROM

credit_update_draw_bypass:
	FREEPLAY
	jmp	$24A7E
/
	movea.w	d0, a0
	moveq	#9, d0
	cmp.l	a0, d0
	jmp	$24A4E

credit_update_bypass:
	move.l	d2, -(sp)
	move.l	8(sp), d0
	FREEPLAY
	moveq	#0, d2
	jmp	$024A22
/
	jmp	$024A20

demo_credit_bypass:
	FREEPLAY
	; "put in" 2 credits.
	move.w	#2, d1
/
	move.b	(InputSysEdge).l, d0
	rts

title_credit_bypass:
	FREEPLAY
	move.b	InputSysEdge, d0
	btst	#4, d0
	bne	.start_p1
	btst	#5, d0
	bne	.start_p2
	jmp	$62A6
.start_p1:
	jmp	$5622
.start_p2:
	jmp	$5E18
/
	cmp.w	(CreditCount).l, d0
	jmp	$55DC

story_credit_bypass:
	FREEPLAY
	move.b	InputSysEdge, d0
	btst	#4, d0
	bne	.start_p1
	btst	#5, d0
	bne	.start_p2
	jmp	$02CC84
.start_p1:
	jmp	$02C324
.start_p2:
	jmp	$02C3B2
/
	move.w	(CreditCount).l, d0
	jmp	$02C216

LAST_ROM	:=	*
