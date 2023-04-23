# Disciplina: Arquitetura e Organização de Processadores  
# Atividade: Avaliação 02 – Programação em Linguagem de Montagem 
# Programa 02
# Alunos: - Arthur de Oliveira Pereira  
#		  - Henrik Gomes Baltazar  
# -------------------------------------------------------------------# 
# ----------- Código em C++ com a biblioteca std incluida -----------# 
#	int Vetor_A[7] = {0};
#	int tamanho = 0;
#	int i;
#  
#	while (tamanho < 2 || tamanho > 8){
#		cout << "Entre com o tamanho do vetor (max. = 8): ";
#  		cin >> tamanho;
#    
#		if (tamanho < 1 || tamanho > 8)
#    	cout << "Valor invalido.\n";
#	}
#
#	for (i = 0; i < tamanho; i++){
#		cout << "Vetor_A[" << i << "]: ";
#    	cin >> Vetor_A[i];
#  	}
#
#	cout << "Digite o indice do valor a ser impresso: ";
#  	cin >> i;
#
#  	cout << "O elemento do vetor na posicao " << i << " possui o valor " << Vetor_A[i];


	.data
		Vetor_A: .word 0 0 0 0 0 0 0 0
		
		msgInicial:	.asciz "Entre com o tamanho do vetor (max. = 8): "
		msgInvalido:.asciz "Valor invalido.\n"
		msgVetor1:	.asciz "Vetor_A["
		msgVetor2:	.asciz "] = "
		msgIndice:	.asciz "Digite o indice do valor a ser impresso: "
		msgFinal1:	.asciz "O elemento do vetor na posicao "
		msgFinal2: 	.asciz " possui o valor "


	.text
	
#-------------while para inserir a quantidade de elementos---------------#
##########################################
#### TODO: Mensagem de "valor invalido"###
##########################################
while:
	# Se t2 != 0 entra sigifnica que o processo ja foi percorrido, logo
	# sera printada a mensagem de "valor invalido"
	
	
	mv t2, zero			# zera o t2
	addi t0, zero, 8 	# t0 = 8 (limite de posicoes)
	li a7, 4			# a7 = codigo para printar string
	la a0, msgInicial	# a0 = msgInicial (endereco)
	ecall				# printa "Entre com o tamanho do vetor (max. = 8): "
	
	li a7, 5			# a7 = carrega o codigo para entrar com um inteiro
	ecall				# chamada para o usuario entrar com um inteiro
	
	# Prmeiro teste: tamanho < 2?
	slti t1, a0, 2 		# t1 = (size < 2)
	bne t1, zero, while	# se (size < 2) vai para while
	# Segundo teste: tamanho > 8?
	bgt a0, t0, while	# se (i > 8) vai para while
	
	# Caso o valor esteja entre 1 e 8
	mv s2, a0			# s2 = a0 (s2 = size)

#--------------------- Declaracoes antes de entrar no loop -----------------------------#
	# s0 = endereco do array
	# s1 = indice logico
	# s2 = size
	# s3 = indice fisico (i * 4)
	# s4 = endereco do array[i]

	la s0, Vetor_A		# s0 = Vetor_A (endereco)
	mv s1, zero			# inicializa o deslocamento (i = 0)

loop:
	slli s3, s1, 2			# s3 = i * 4 (indice fisico)
	add s4, s0, s3			# s4 = endereco do Vetor_A[i]
	#--------------------------------------------------------------------------------- #	
	li a7, 4				# chama do codigo para printar string
	la a0, msgVetor1		# a0 = msgVetor1
	ecall					# printa "Vetor_A["
	li a7, 1				# chama o codigo para printar um inteiro
	mv a0, s1				# a0 = s1 (indice logico)
	ecall					# mostra o inteiro (indice logico)
	li a7, 4				# chama o codigo para printar string
	la a0, msgVetor2		# a0 = msgVetor2
	ecall					# printa "] = "
	li a7, 5				# chama o codigo para ler um inteiro
	ecall					# chamada para o usuario entrar com um input (inteiro)
	#-------------------------------------------------------------------------------- #	
	sw a0, 0(s4)			# a0 = valor armazenado atraves do input vindo pelo ecall
							# s4 = Vetor_A[i], logo, Vetor_A[i] = a0
							
	addi s1, s1, 1			# i = i + 1 (logico)
	slt t0, s1, s2 			# t0 = (i < size)
	bne t0, zero, loop		# se (i < size) vai para loop

# ----------------- Pede o indice do elemento que sera impresso ----------------- #
###############################
### TODO: Testes de entrada ###
##############################
indexInput:
	li a7, 4				# carrega o codigo para printar string
	la a0, msgIndice		# a0 = msgIndice
	ecall					# printa "Digite o indice do valor a ser impresso: "
	li a7, 5				# carrega o codigo para ler inteiro
	ecall					# chamada para ler um inteiro
	mv s1, a0				# s1 = a0 (s1 recebe o indice logico)
	
	# Prmeiro teste: tamanho < 0?
	slti t1, a0, 0 			# t1 = (size < 2)
	bne t1, zero, indexInput	# se (size < 2) vai para while
	# Segundo teste: tamanho > size?
	addi t2, zero, 1
	sub t1, s2, t2
	bgt a0, t1, indexInput	# se (i > 8) vai para while
	#---------------------------- Mostra o elemento do vetor -----------------------#
	li a7, 4				# carrega o codigo para printar string
	la a0, msgFinal1		# a0 = msgFinal1
	ecall					# printa "O elemento do vetor na posicao "
	li a7, 1				# carrega o codigo para printar inteiro
	mv a0, s1				# a0 = s1 (a0 recebe o indice logico)
	ecall					# chamada para mostrar o indice logico
	li a7, 4				# carrega o codigo para printar string
	la a0, msgFinal2		# a0 = msgFinal2
	ecall					# printa " possui o valor "
	
	#----Carregando o valor-----#
	slli t1, s1, 2			# t1 = i * 4
	add  s4, s0, t1			# s4 = endereco do Vetor_A[i]
	lw a0, 0(s4)			# a0 = s4 (s4 = array[i])
	li a7, 1				# chamada para printar o elemeto do array
	ecall					# printa o elemento A[i]

exit:
	li a7, 10			# finaliza o programa com o codigo 0
   	ecall				# chamada de saida