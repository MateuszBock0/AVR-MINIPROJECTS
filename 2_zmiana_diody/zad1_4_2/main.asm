;
; zad1_4_2.asm
;
; Created: 19.03.2024 08:42:27
; Author : Student
;
// Wciœniêcie i przytrzymanie przycisku diody powoduje zapalanie
// Diody s¹ po³¹czone z portem A: PA (wszystkie kolejno)
// Przycisk 1 - LEWO po³¹czony z GROUNDEM i z pinem przerwania: PD2
// Przycisk 2 - PRAWO po³¹czony z GROUNDEM i z pinem przerwania: PD3

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
	LDI R16, 0b11000000
	OUT GICR, R16
	SEI

	OUT DDRA, R17
	OUT PORTA, R18	// Port A to wyjœcie, które pokazuje 0 - dioda siê nie œwieci

	LDI R19, 0b10000000
RJMP start

przerwanie:
	SBIS PIND, 2
	RCALL lewo

	SBIS PIND, 3
	RCALL prawo
RETI

lewo:
	ROL R19
	RCALL czekaj
	OUT PORTA, R19
RET

prawo:
	ROR R19
	RCALL czekaj
	OUT PORTA, R19
RET

czekaj:
	LDI R20, 255
	w1:
		NOP
		LDI R21, 255
		w2:
			NOP
			DEC R21
			BRNE w2
		DEC R20
		BRNE w1
RET
