;
; USRROM	TEMPLATE FOR A CUSTOM USER ROM
;
#INCLUDE	"std.asm"
;
CR	.EQU    0DH
LF	.EQU    0AH
;
	.ORG    USR_LOC
;
	LD	SP,USR_END
;
	LD	HL,BOOTMSG		; INTRODUCTION
	CALL	PRTSTR
;
	CALL	CIN			; DO STUFF
;
	LD	B,BF_SYSRESET		; SYSTEM RESTART
	LD	C,BF_SYSRES_WARM	; WARM START
	CALL	$FFF0			; CALL HBIOS
;       RET
;
;
;
; PRINT A STRING AT ADDRESS SPECIFIED IN HL
; STRING MUST BE TERMINATED BY '$'
; USAGE:
;   LD	HL,MYSTR
;   CALL PRTSTR
;   ...
;   MYSTR: .DB  "HELLO$"
;
PRTSTR:	LD	A,(HL)
	INC	HL
	CP	'$'
	RET	Z
	CALL	COUT
	JR	PRTSTR
;
; OUTPUT CHARACTER IN A TO CONSOLE DEVICE
;
COUT:	PUSH	AF
	PUSH	BC
	PUSH	DE
	PUSH	HL
	LD	B,01H
	LD	C,80H
	LD	E,A
	RST	08
	POP	HL
	POP	DE
	POP	BC
	POP	AF
	RET
;
; WAIT FOR A CHARACTER FROM THE CONSOLE DEVICE AND RETURN IT IN A
;
CIN:	PUSH	BC
	PUSH	DE
	PUSH	HL
	LD	B,00H
	LD	C,80H
	RST	08
	LD	A,E
	POP	HL
	POP	DE
	POP	BC
	RET
;
BOOTMSG:.DB	CR,LF,CR,LF
	.DB	"No User ROM Installed."
	.DB	CR,LF,CR,LF
	.DB	"Press a key to return to Boot Loader.$"
;
; IT IS CRITICAL THAT THE FINAL BINARY BE EXACTLY USR_SIZ BYTES.
; THIS GENERATES FILLER AS NEEDED.
;				
SLACK	.EQU	(USR_END - $)
	.FILL	SLACK,00
	.ECHO	"User ROM space remaining: "
	.ECHO	SLACK
	.ECHO	" bytes.\n"
        .END

