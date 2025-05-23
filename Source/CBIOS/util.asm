;
;==================================================================================================
; UTILITY FUNCTIONS
;==================================================================================================
;
;
CHR_CR		.EQU	0DH
CHR_LF		.EQU	0AH
CHR_BS		.EQU	08H
CHR_ESC		.EQU	1BH
;
;__________________________________________________________________________________________________
;
; UTILITY PROCS TO PRINT SINGLE CHARACTERS WITHOUT TRASHING ANY REGISTERS
;
PC_SPACE:
	PUSH	AF
	LD	A,' '
	JR	PC_PRTCHR

PC_PERIOD:
	PUSH	AF
	LD	A,'.'
	JR	PC_PRTCHR

PC_COLON:
	PUSH	AF
	LD	A,':'
	JR	PC_PRTCHR

;PC_COMMA:
;	PUSH	AF
;	LD	A,','
;	JR	PC_PRTCHR

PC_LBKT:
	PUSH	AF
	LD	A,'['
	JR	PC_PRTCHR

PC_RBKT:
	PUSH	AF
	LD	A,']'
	JR	PC_PRTCHR

;PC_LT:
;	PUSH	AF
;	LD	A,'<'
;	JR	PC_PRTCHR

;PC_GT:
;	PUSH	AF
;	LD	A,'>'
;	JR	PC_PRTCHR

;PC_LPAREN:
;	PUSH	AF
;	LD	A,'('
;	JR	PC_PRTCHR

;PC_RPAREN:
;	PUSH	AF
;	LD	A,')'
;	JR	PC_PRTCHR

;PC_ASTERISK:
;	PUSH	AF
;	LD	A,'*'
;	JR	PC_PRTCHR

PC_CR:
	PUSH	AF
	LD	A,CHR_CR
	JR	PC_PRTCHR

PC_LF:
	PUSH	AF
	LD	A,CHR_LF
	JR	PC_PRTCHR

PC_PRTCHR:
	CALL	COUT
	POP	AF
	RET

NEWLINE2:
	CALL	NEWLINE
NEWLINE:
	CALL	PC_CR
	CALL	PC_LF
	RET
;
; OUTPUT A '$' TERMINATED STRING
;
WRITESTR:
	PUSH	AF
WRITESTR1:
	LD	A,(DE)
	CP	'$'			; TEST FOR STRING TERMINATOR
	JP	Z,WRITESTR2
	CALL	COUT
	INC	DE
	JP	WRITESTR1
WRITESTR2:
	POP	AF
	RET
;
#IF DEBUG
;
; PRINT A STRING AT ADDRESS SPECIFIED IN HL
; STRING MUST BE TERMINATED BY '$'
; USAGE:
;   LD	HL,MYSTR
;   CALL PRTSTR
;   ...
;   MYSTR: .DB  "HELLO$"
;
PRTSTR:
	LD	A,(HL)
	INC	HL
	CP	'$'
	RET	Z
	CALL	COUT
	JR	PRTSTR
;
; PRINT A STRING DIRECT: REFERENCED BY POINTER AT TOP OF STACK
; STRING MUST BE TERMINATED BY '$'
; USAGE:
;   CALL PRTSTRD
;   .DB  "HELLO$"
;   ...
;
PRTSTRD:
	EX	(SP),HL
	PUSH	AF
	CALL	PRTSTR
	POP	AF
	EX	(SP),HL
	RET
;
; PRINT A STRING INDIRECT: REFERENCED BY INDIRECT POINTER AT TOP OF STACK
; STRING MUST BE TERMINATED BY '$'
; USAGE:
;   CALL PRTSTRI(MYSTRING)
;   MYSTRING	.DB	"HELLO$"
;
PRTSTRI:
	EX	(SP),HL
	PUSH	AF
	LD	A,(HL)
	INC	HL
	PUSH	HL
	LD	H,(HL)
	LD	L,A
	CALL	PRTSTR
	POP	HL
	INC	HL
	POP	AF
	EX	(SP),HL
	RET
;
#ENDIF
;
; PANIC: TRY TO DUMP MACHINE STATE
;
PANIC:
	PUSH	DE
	LD	DE,STR_PANIC
	CALL	WRITESTR
	POP	DE
	CALL	_REGDMP			; DUMP REGISTERS
	CALL	CONTINUE		; CHECK W/ USER
	RET
;
;
;
REGDMP:
	CALL	_REGDMP
	RET
;
_REGDMP:
	EX	(SP),HL			; RET ADR TO HL, SAVE HL ON TOS
	LD	(REGDMP_RET),HL		; SAVE RETURN ADDRESS
	POP	HL			; RESTORE HL AND BURN STACK ENTRY

	EX	(SP),HL			; PC TO HL, SAVE HL ON TOS
	LD	(REGDMP_PC),HL		; SAVE PC VALUE
	EX	(SP),HL			; BACK THE WAY IT WAS

	LD	(REGDMP_SP),SP		; SAVE STACK POINTER

	;LD	(RD_STKSAV),SP		; SAVE ORIGINAL STACK POINTER
	;LD	SP,RD_STACK		; SWITCH TO PRIVATE STACK

	PUSH	AF
	PUSH	BC
	PUSH	DE
	PUSH	HL

	PUSH	AF
	LD	A,'@'
	CALL	COUT
	POP	AF

	PUSH	BC
	LD	BC,(REGDMP_PC)
	CALL	PRTHEXWORD		; PC
	POP	BC
	CALL	PC_LBKT
	PUSH	BC
	PUSH	AF
	POP	BC
	CALL	PRTHEXWORD		; AF
	POP	BC
	CALL	PC_COLON
	CALL	PRTHEXWORD		; BC
	CALL	PC_COLON
	PUSH	DE
	POP	BC
	CALL	PRTHEXWORD		; DE
	CALL	PC_COLON
	PUSH	HL
	POP	BC
	CALL	PRTHEXWORD		; HL
	CALL	PC_COLON
	LD	BC,(REGDMP_SP)
	CALL	PRTHEXWORD		; SP

	CALL	PC_RBKT
	CALL	PC_SPACE

	POP	HL
	POP	DE
	POP	BC
	POP	AF

	;LD	SP,(RD_STKSAV)		; BACK TO ORIGINAL STACK FRAME

	JP	$FFFF			; RETURN, $FFFF IS DYNAMICALLY UPDATED
REGDMP_RET	.EQU	$-2		; RETURN ADDRESS GOES HERE
;
REGDMP_PC	.DW	0
REGDMP_SP	.DW	0
;
;RD_STKSAV	.DW	0
;		.FILL	$FF,16*2	; 16 LEVEL PRIVATE STACK
;RD_STACK	.EQU	$
;
;
;
CONTINUE:
	PUSH	AF
	PUSH	DE
	LD	DE,STR_CONTINUE
	CALL	WRITESTR
	POP	DE
CONTINUE1:
	CALL	CIN
	CP	'Y'
	JR	Z,CONTINUE3
	CP	'y'
	JR	Z,CONTINUE3
	CP	'N'
	JR	Z,CONTINUE2
	CP	'n'
	JR	Z,CONTINUE2
	JR	CONTINUE1
CONTINUE2:
	HALT
CONTINUE3:
	POP	AF
	RET
;
;==================================================================================================
; CONSOLE CHARACTER I/O HELPER ROUTINES (REGISTERS PRESERVED)
;==================================================================================================
;
; OUTPUT CHARACTER FROM A
COUT:
	PUSH	AF
	PUSH	BC
	PUSH	DE
	PUSH	HL
	LD	C,A
	CALL	CONOUT
	POP	HL
	POP	DE
	POP	BC
	POP	AF
	RET
;
;
;
CIN:
	PUSH	BC
	PUSH	DE
	PUSH	HL
	CALL	CONIN
	LD	A,E
	POP	HL
	POP	DE
	POP	BC
	RET
;
STR_PANIC	.DB	"\r\n\r\n>>> PANIC: $"
STR_TSTPT	.TEXT	"\r\n+++ TSTPT: $"
STR_CONTINUE	.TEXT	" Continue? (Y/N): $"
;STR_AF		.DB	" AF=$"
;STR_BC		.DB	" BC=$"
;STR_DE		.DB	" DE=$"
;STR_HL		.DB	" HL=$"
;STR_PC		.DB	" PC=$"
;STR_SP		.DB	" SP=$"
;
; INDIRECT JUMP TO ADDRESS IN HL
;
;   MOSTLY USEFUL TO PERFORM AN INDIRECT CALL LIKE:
;     LD	HL,xxxx
;     CALL	JPHL
;
JPHL:	JP	(HL)
;
; ADD HL,A
; ADC HL,A
;
;   A REGISTER IS DESTROYED!
;
ADCHLA:
	ADC	A,L
	JR	ADDHLA1
ADDHLA:
	ADD	A,L
ADDHLA1:
	LD	L,A
	RET	NC
	INC	H
	RET
;
; MULTIPLY 8-BIT VALUES
; IN:  MULTIPLY H BY E
; OUT: HL = RESULT, E = 0, B = 0
;
;MULT8:
;	LD D,0
;	LD L,D
;	LD B,8
;MULT8_LOOP:
;	ADD HL,HL
;	JR NC,MULT8_NOADD
;	ADD HL,DE
;MULT8_NOADD:
;	DJNZ MULT8_LOOP
;	RET
;
; FILL MEMORY AT HL WITH VALUE A, LENGTH IN BC, ALL REGS USED
; LENGTH *MUST* BE GREATER THAN 1 FOR PROPER OPERATION!!!
;
FILL:
	LD	D,H		; SET DE TO HL
	LD	E,L		; SO DESTINATION EQUALS SOURCE
	LD	(HL),A		; FILL THE FIRST BYTE WITH DESIRED VALUE
	INC	DE		; INCREMENT DESTINATION
	DEC	BC		; DECREMENT THE COUNT
	LDIR			; DO THE REST
	RET			; RETURN
;
; PRINT THE HEX BYTE VALUE IN A
;
PRTHEXBYTE:
	PUSH	AF
	PUSH	DE
	CALL	HEXASCII
	LD	A,D
	CALL	COUT
	LD	A,E
	CALL	COUT
	POP	DE
	POP	AF
	RET
;
; PRINT THE HEX WORD VALUE IN BC
;
PRTHEXWORD:
	PUSH	AF
	LD	A,B
	CALL	PRTHEXBYTE
	LD	A,C
	CALL	PRTHEXBYTE
	POP	AF
	RET
;
; CONVERT BINARY VALUE IN A TO ASCII HEX CHARACTERS IN DE
;
HEXASCII:
	LD	D,A
	CALL	HEXCONV
	LD	E,A
	LD	A,D
	RLCA
	RLCA
	RLCA
	RLCA
	CALL	HEXCONV
	LD	D,A
	RET
;
; CONVERT LOW NIBBLE OF A TO ASCII HEX
;
HEXCONV:
	AND	0FH	     ;LOW NIBBLE ONLY
	ADD	A,90H
	DAA
	ADC	A,40H
	DAA
	RET
;
;****************************
;	A(BCD) => A(BIN)
;	[00H..99H] -> [0..99]
;****************************
;
BCD2BYTE:
	PUSH	BC
	LD	C,A
	AND	0F0H
	SRL	A
	LD	B,A
	SRL	A
	SRL	A
	ADD	A,B
	LD	B,A
	LD	A,C
	AND	0FH
	ADD	A,B
	POP	BC
	RET
;
;*****************************
;	 A(BIN) =>  A(BCD)
;	[0..99] => [00H..99H]
;*****************************
;
;BYTE2BCD:
;	PUSH	BC
;	LD	B,10
;	LD	C,-1
;BYTE2BCD1:
;	INC	C
;	SUB	B
;	JR	NC,BYTE2BCD1
;	ADD	A,B
;	LD	B,A
;	LD	A,C
;	ADD	A,A
;	ADD	A,A
;	ADD	A,A
;	ADD	A,A
;	OR	B
;	POP	BC
;	RET
;
; PRINT A BYTE BUFFER IN HEX POINTED TO BY DE
; REGISTER A HAS SIZE OF BUFFER
;
;PRTHEXBUF:
;	OR	A
;	RET	Z		; EMPTY BUFFER
;
;	LD	B,A
;PRTHEXBUF1:
;	CALL	PC_SPACE
;	LD	A,(DE)
;	CALL	PRTHEXBYTE
;	INC	DE
;	DJNZ	PRTHEXBUF1
;	RET
;
; LEFT SHIFT DE:HL BY B BITS (B > 0)
;
RL32:
	OR	A			; CLEAR CARRY
	RL	L
	RL	H
	RL	E
	RL	D
	DJNZ	RL32
	RET

