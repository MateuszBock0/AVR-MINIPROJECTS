;
; zad1_4.asm
;
; Created: 19.03.2024 07:42:55
; Author : Student
;

// Wciœniêcie i przytrzymanie przycisku diody powoduje zapalanie
// Dioda jest po³¹czona z portem A: PA0
// Przycisk po³¹czony z GROUNDEM i z pinem przerwania: PD3

.org $000	// RESET
	RJMP start
.org $004	// INT1
	RJMP przerwanie

start:
	LDI R16, low(RAMEND)
	OUT SPL, R16
	LDI R16, high(RAMEND)
	OUT SPH, R16

	LDI R17, 0b11111111
	LDI R18, 0b00000000
	OUT DDRD, R18
	OUT PORTD, R17	// Port D to wejœcie, z pull-up

	LDI R16, 0b00000010
	OUT MCUCSR, R16
	LDI R16, 0b10000000
	OUT GICR, R17
	SEI

	OUT DDRA, R17
	OUT PORTA, R18	// Port A to wyjœcie, które pokazuje 0 - dioda siê nie œwieci
RJMP start


przerwanie:
	OUT PORTA, R17	//zmieñ stan na diodzie na 1 - zaœwieæ
RETI