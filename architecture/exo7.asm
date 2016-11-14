;;;;;;;;;;;;;;;;;;;;;;;
;;        TD 5       ;;
;;     exercice 7    ;;
;;;;;;;;;;;;;;;;;;;;;;;

.ORIG x3000

LEA R0,ch 			;charge l'adresse ch dans R0
JSR nbchiffres 		;appel a la routine nbchiffres
ST R1,r 			;range le resultat a l'adresse r
HALT 				;rend la main au systeme d'exploitation

ch 	.STRINGZ "2 fois 3 fait 6"
r 	.BLKW 1
zero .FILL 48 	;valeur ASCII du caractere '0'
neuf .FILL 57 	;valeur ASCII du caractere '9'
				;;;Si tu t'es perdu dans l'espace-temps,
				;;;ce qu'il y a entre les deux, c'est '1' '2' '3' etc...

nbchiffres
	AND R1,R1,#0 	;R1<-0
	ADD R2,R0,#0 	;R2<-R0
	LDR R3,R2,#0 	;R3<-mem[R2]

	loop ADD R0,R3,0 ;R3+0, si le resultat = 0 alors R3=0='\0', et ouai bien vu l'autiste
	BRz endloop 		;while(R3 != '\0') du coup si == 0
		LD R0,zero		;on prend la valeur du zero (48)
		NOT R0,R0 		;;;On inverse et +1 pour faire le complement a 2
		ADD R0,R0,1 	;;;et finalement obtenir -48 (ouai c sur 2 ligne maggle)
		ADD R0,R3,R0 	;hop R3+(-48)= ???
		BRn infzero 	;si <0 ca veut dire R3 < '0' donc c'est pas un charactere chiffre
			LD R0,neuf 	
			NOT R0,R0		;;;maintenant on fait le meme cirque pour
			ADD R0,R0,1		;;;savoir si ca depasse pas, le charactere '9' de
			ADD R0,R3,R0 	;;;cette foutue table ASCII (57 quoi)
			BRp supneuf
				ADD R1,R1,#1 	;voila enfin, on y est lol : R1++
			supneuf
		infzero

		ADD R2,R2,#1 	;hop on avance d'une case du tableau
		LDR R3,R2,#0 	;et balance ca dans R3
	BR loop
	endloop
RET

.END