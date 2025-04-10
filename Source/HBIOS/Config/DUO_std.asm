;
;==================================================================================================
;   ROMWBW DEFAULT BUILD SETTINGS FOR DUODYNE
;==================================================================================================
;
; THIS FILE DEFINES THE DEFAULT CONFIGURATION SETTINGS FOR THE PLATFORM
; INDICATED ABOVE.  THESE SETTINGS DEFINE THE OFFICIAL BUILD FOR THIS
; PLATFORM AS DISTRIBUTED IN ROMWBW RELEASES.
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
; TO CUSTOMIZE YOUR BUILD SETTINGS YOU SHOULD MODIFY THIS FILE, THE
; DEFAULT BUILD SETTINGS (Config/<platform>_std.asm) OR PREFERABLY
; CREATE AN OPTIONAL CUSTOM USER SETTINGS FILE THAT INCLUDES THE DEFAULT
; BUILD SETTINGS FILE (SEE EXAMPLE Config/SBC_user.asm).
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
#DEFINE AUTO_CMD	""		; AUTO CMD WHEN BOOT_TIMEOUT IS ENABLED
#DEFINE DEFSERCFG	SER_38400_8N1 | SER_RTS		; DEFAULT SERIAL CONFIGURATION
;
#INCLUDE "cfg_DUO.asm"
;
BOOT_TIMEOUT	.SET	-1		; AUTO BOOT TIMEOUT IN SECONDS, -1 TO DISABLE, 0 FOR IMMEDIATE
BOOT_PRETTY	.SET	FALSE		; BOOT WITH PRETTY PLATFORM NAME
BT_REC_TYPE	.SET	BT_REC_NONE	; BOOT RECOVERY METHOD TO USE: BT_REC_[NONE|FORCE|SBCB0|SBC1B|SBCRI|DUORI]
AUTOCON		.SET	TRUE		; ENABLE CONSOLE TAKEOVER AT LOADER PROMPT
;
BATCOND		.SET	TRUE		; ENABLE LOW BATTERY WARNING MESSAGE
CPUOSC		.SET	8000000		; CPU OSC FREQ IN MHZ
INTMODE		.SET	2		; INTERRUPTS: 0=NONE, 1=MODE 1, 2=MODE 2, 3=MODE 3 (Z280)
;
RAMSIZE		.SET	512		; SIZE OF RAM IN KB (MUST MATCH YOUR HARDWARE!!!)
ROMSIZE		.SET	512		; SIZE OF ROM IN KB (MUST MATCH YOUR HARDWARE!!!)
;
PCFENABLE	.SET	TRUE		; ENABLE PCF8584 I2C CONTROLLER
;
CRTACT		.SET	FALSE		; ACTIVATE CRT (VDU,CVDU,PROPIO,ETC) AT STARTUP
VDAEMU_SERKBD	.SET	$FF		; VDA EMULATION: SERIAL KBD UNIT #, OR $FF FOR HW KBD
;
DSRTCENABLE	.SET	TRUE		; DSRTC: ENABLE DS-1302 CLOCK DRIVER (DSRTC.ASM)
INTRTCENABLE	.SET	FALSE		; ENABLE PERIODIC INTERRUPT CLOCK DRIVER (INTRTC.ASM)
;
UARTENABLE	.SET	TRUE		; UART: ENABLE 8250/16550-LIKE SERIAL DRIVER (UART.ASM)
UARTINTS	.SET	FALSE		; UART: INCLUDE INTERRUPT SUPPORT UNDER IM1/2/3
SIOENABLE	.SET	TRUE		; SIO: ENABLE ZILOG SIO SERIAL DRIVER (SIO.ASM)
;
TMSENABLE	.SET	FALSE		; TMS: ENABLE TMS9918 VIDEO/KBD DRIVER (TMS.ASM)
TMS80COLS	.SET	FALSE		; TMS: ENABLE 80 COLUMN SCREEN, REQUIRES V9958
;
MDFFENABLE	.SET	FALSE		; MD: ENABLE FLASH FILE SYSTEM
FDENABLE	.SET	TRUE		; FD: ENABLE FLOPPY DISK DRIVER (FD.ASM)
FD0TYPE		.SET	FDT_3HD		; FD 0: DRIVE TYPE: FDT_[3DD|3HD|5DD|5HD|8]
FD1TYPE		.SET	FDT_3HD		; FD 1: DRIVE TYPE: FDT_[3DD|3HD|5DD|5HD|8]
PPIDEENABLE	.SET	TRUE		; PPIDE: ENABLE PARALLEL PORT IDE DISK DRIVER (PPIDE.ASM)
SDENABLE	.SET	TRUE		; SD: ENABLE SD CARD DISK DRIVER (SD.ASM)
;
CHENABLE	.SET	TRUE		; CH: ENABLE CH375/376 USB SUPPORT
ESPENABLE	.SET	FALSE		; ESP: ENABLE ESP32 IO BOARD DRIVER (ESP.ASM)
SN76489ENABLE	.SET	FALSE		; SN: ENABLE SN76489 SOUND DRIVER
AY38910ENABLE	.SET	FALSE		; AY: ENABLE AY-3-8910 / YM2149 SOUND DRIVER
;
DMAENABLE	.SET	TRUE		; DMA: ENABLE DMA DRIVER (DMA.ASM)
