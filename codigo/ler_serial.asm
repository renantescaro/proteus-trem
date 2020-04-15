
_main:

;ler_serial.mbas,5 :: 		MAIN:
;ler_serial.mbas,7 :: 		TRISA = %00000000
	CLRF       TRISA+0
;ler_serial.mbas,8 :: 		TRISB = %00000000
	CLRF       TRISB+0
;ler_serial.mbas,9 :: 		TRISC = %00000000
	CLRF       TRISC+0
;ler_serial.mbas,11 :: 		porta = 0
	CLRF       PORTA+0
;ler_serial.mbas,12 :: 		portb = 0
	CLRF       PORTB+0
;ler_serial.mbas,13 :: 		portc = 0
	CLRF       PORTC+0
;ler_serial.mbas,15 :: 		UART1_Init(9600)
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;ler_serial.mbas,16 :: 		Delay_ms(100)
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L__main1:
	DECFSZ     R13+0, 1
	GOTO       L__main1
	DECFSZ     R12+0, 1
	GOTO       L__main1
	NOP
	NOP
;ler_serial.mbas,18 :: 		WHILE true
L__main3:
;ler_serial.mbas,20 :: 		if (UART1_Data_Ready() = 1) then
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main8
;ler_serial.mbas,21 :: 		TRISC = %00000000
	CLRF       TRISC+0
;ler_serial.mbas,22 :: 		recebido = UART1_Read()
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _recebido+0
;ler_serial.mbas,25 :: 		if(recebido = "a") then
	MOVF       R0+0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L__main11
;ler_serial.mbas,26 :: 		setbit(portc, 0)
	BSF        PORTC+0, 0
L__main11:
;ler_serial.mbas,30 :: 		if(recebido = "b") then
	MOVF       _recebido+0, 0
	XORLW      98
	BTFSS      STATUS+0, 2
	GOTO       L__main14
;ler_serial.mbas,31 :: 		clearbit(portc, 0)
	BCF        PORTC+0, 0
L__main14:
;ler_serial.mbas,35 :: 		if(recebido = "c") then
	MOVF       _recebido+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L__main17
;ler_serial.mbas,36 :: 		setbit(portc, 1)
	BSF        PORTC+0, 1
L__main17:
;ler_serial.mbas,40 :: 		if(recebido = "d") then
	MOVF       _recebido+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L__main20
;ler_serial.mbas,41 :: 		clearbit(portc, 1)
	BCF        PORTC+0, 1
L__main20:
;ler_serial.mbas,42 :: 		end if
L__main8:
;ler_serial.mbas,45 :: 		WEND
	GOTO       L__main3
L_end_main:
	GOTO       $+0
; end of _main
