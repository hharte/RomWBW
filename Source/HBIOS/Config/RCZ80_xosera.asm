;
;==================================================================================================
;   ROMWBW CUSTOM USER BUILD SETTINGS EXAMPLE FOR RCBUS Z80
;==================================================================================================
;
; THIS FILE IS AN EXAMPLE OF A CUSTOM USER SETTINGS FILE.  THESE
; SETTINGS OVERRIDE THE DEFAULT SETTINGS OF THE INHERITED FILES AS
; DESIRED BY A USER.
;
; ROMWBW USES CASCADING CONFIGURATION FILES AS INDICATED BELOW:
;
; cfg_MASTER.asm			- MASTER: CONFIGURATION FILE DEFINES ALL POSSIBLE ROMWBW SETTINGS
; |
; +-> cfg_<platform>.asm		- PLATFORM: DEFAULT SETTINGS FOR SPECIFIC PLATFORM
;     |
;     +-> Config/<plt>_std.asm		- BUILD: SETTINGS FOR EACH OFFICIAL DIST BUILD
;         |
;         +-> Config/<plt>_<cust>.asm	- USER: CUSTOM USER BUILD SETTINGS
;
; THE TOP (MASTER CONFIGURATION) FILE DEFINES ALL POSSIBLE ROMWBW
; CONFIGURATION SETTINGS. EACH FILE BELOW THE MASTER CONFIGURATION FILE
; INHERITS THE CUMULATIVE SETTINGS OF THE FILES ABOVE IT AND MAY
; OVERRIDE THESE SETTINGS AS DESIRED.
;
; OTHER THAN THE TOP MASTER FILE, EACH FILE MUST "#INCLUDE" ITS PARENT
; FILE (SEE #INCLUDE STATEMENT BELOW).  THE TOP TWO FILES SHOULD NOT BE
; MODIFIED.
;
; THIS FILE EXEMPLIFIES THE IDEAL WAY TO CREATE A USER SPECIFIC BUILD
; CONFIGURATION.  NOTICE THAT IT INCLUDES THE DEFAULT BUILD SETTINGS
; FILE AND OVERRIDES SOME DESIRED SETTINGS.
;
; BY CREATING A CUSTOM USER SETTINGS FILE, YOU ARE LESS LIKELY TO BE
; IMPACTED BY FUTURE CHANGES BECAUSE YOU WILL BE INHERITING MOST
; OF YOUR SETTINGS WHICH WILL BE UPDATED BY AUTHORS AS ROMWBW EVOLVES.
;
; PLEASE REFER TO THE CUSTOM BUILD INSTRUCTIONS (README.TXT) IN THE
; SOURCE DIRECTORY (TWO DIRECTORIES ABOVE THIS ONE).
;
; *** WARNING: ASIDE FROM THE MASTER CONFIGURATION FILE, YOU MUST USE
; ".SET" TO OVERRIDE SETTINGS.  THE ASSEMBLER WILL ERROR IF YOU ATTEMPT
; TO USE ".EQU" BECAUSE IT WON'T LET YOU REDEFINE A SETTING WITH ".EQU".
;
; THIS FILE ENABLES THE XOSERA DRIVER WITH A BASE ADDRESS Of $A0 AND 
; DISPLAY SIZE OF 80 COLUMNS X 30 ROWS.
;
#INCLUDE "Config/RCZ80_std.asm"		; INHERIT FROM OFFICIAL BUILD SETTINGS
;
XOSENABLE	.SET	TRUE		; XOSERA: ENABLE XOSERA VIDEO DRIVERS (XOSERA.ASM)
XOS_BASE	.SET	$A0		; XOSERA: I/O BASE ADDRESS (REQUIRES 32 BYTES)
XOSSIZ		.SET	V80X30		; XOSERA: DISPLAY FORMAT [V80X30|V80X60]
;
AUTOCON		.SET	FALSE		; ENABLE CONSOLE TAKEOVER AT LOADER PROMPT
VDAEMU_SERKBD	.SET	$0		; VDA EMULATION: SERIAL KBD UNIT #, OR $FF FOR HW KBD
;
; WHEN A XOSERA BOARD IN IS THE SYSTEM, LIMIT THE NUMBER OF UARTS THAT ARE PROBED
; TO TWO, BECAUSE THE PROBE TO DETECT A THIRD UART WRITES UNLUCKY VALUES TO 
; XOSERA THAT CAUSE IT TO RECONFIGURE ITSELF AND LOCK UP THE BUS FOR A TIME. IF
; YOU NEED MORE THAN TWO UARTS, YOU WILL NEED TO MOVE XOSERA OUT OF THE $A0-$BF
; I/O ADDRESS REGION.
UARTCNT		.SET	2
