;;;;;;;;;;;;;;;;;;;;;;;
;;        TD 5       ;;
;;     exercice 4    ;;
;;;;;;;;;;;;;;;;;;;;;;;


.ORIG x3000

;main program

LEA R6,stackend

LEA R0,msg1
PUTS

LEA R1,ch1
JSR saisie

LEA R0,msg2
PUTS

LEA R0,ch1
PUTS

HALT

;data

msg1 	.STRINGZ "Entrez une chaine"
msg2 	.STRINGZ "Vous avez tape : "
ch1 	.BLKW #8

stack 	.BLKW #5
stackend .FILL #0

saisie
	ADD R6,R6,#-1 ;;;push
	STR R7,R6,#0  ;;;push suite

	ADD R2,R1,#0 ;R2<-R1

		loop ADD R0,R0,#-10
			BRz endloop 		;jump si R0=-10 (touche entree)
			GETC 				;routine qui attend la saisie d'une touche
			OUT 				;routine qui affiche la touche saisie (buffer)
			STR R0,R2,#0 		;R0<-mem[R2]
			ADD R2,R2,#1 		;R2++
		BR loop
		endloop

	LDR R7,R6,#0 ;;;pop
	ADD R6,R6,#1 ;;;pop suite
RET

.END