;;;;;;;;;;;;;;;;;;;;;;;
;;        TD 5       ;;
;;     exercice 1    ;;
;;;;;;;;;;;;;;;;;;;;;;;

.ORIG x3000

;;; 1) <-- voila ca c'est le numero de la sous partie de l'exo, les donnees sont en bas

	LD R1,add0
	LD R0,add1
	ADD R1,R1,R0

	LD R0,add2
	ADD R1,R1,R0

	ST R1,resultat1

;;; 2) soustraction de y1-y2

	LD R0,y1
	LD R1,y2

	NOT R1,R1		; -y2 = not(y2)+1
	ADD R1,R1,#1	; j'ajoute 1 car complement a 2

	ADD R0,R0,R1	; y1+(-y2)

;;; 3)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 			ok, d'abord l'assembleur 		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	LEA R0,debut	;R0 pointe sur la premiere adresse a l'etiquette "debut"

	LEA R1,fin		;on stoque l'adresse de "fin"
	NOT R1,R1 		;et on l'inverse

	AND R2,R2,#0 	;initialisation de R2 a 0

	; condition de boucle
	loop	ADD R3,R0,R1 	;adresse actuelle + not(adresse de "fin")
			BRz endloop	 	;si==0, ca veut dire que adresse actuelle = adresse de fin ("fin"+not("fin")=0)
			
			;corps de la boucle
			LDR R3,R0,0 	;on donne a R3 la valeur contenue a l'adresse stoquee dans R0
			ADD R2,R2,R3 	;et hop on fait l'addition

			ADD R0,R0,1 	;on avance d'une adresse
	BR loop
	endloop

	ST R2,resultat3


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 		pseudo code (du truc au dessus)				;;
	;;	Sur ce coup la, je sais pas trop comment faire 	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;
	;R0 = &debut;
	;R1 = !(&fin);
	;R2 = 0;
	;
	;while R0+R1 != 0{
	;	R2 += *R0;
	;
	;	R0 = &(R0+1);
	;}
	;
	;resultat3 = R2;
	;

HALT

;;;;;;;;;;;;;
;; donnees ;;
;;;;;;;;;;;;;

;;; a)
resultat1 	.BLKW #1
add0 	.FILL #12
add1 	.FILL #45
add2 	.FILL #16

;;; b)
y1 	.FILL #4
y2 	.FILL #3

;;; c)

resultat3 	.BLKW #1
debut 	.FILL #12
		.FILL #45
		.FILL #16
		.FILL #06
fin		.FILL #78

.END