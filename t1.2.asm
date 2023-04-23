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
#---------------- Loop While para inserir a quantidade de elementos ------------------#
while:
	la s5, while		# s5 = endereco de while
	addi t0, zero, 8 	# t0 = 8 (limite de posicoes)
	li a7, 4			# a7 = carrega o codigo para printar string
	la a0, msgInicial	# a0 = msgInicial (endereco)
	ecall				# printa "Entre com o tamanho do vetor (max. = 8): "
	
	li a7, 5			# a7 = carrega o codigo para entrar com um inteiro
	ecall				# chamada para o usuario entrar com um inteiro
	
	jal validateSize	# pula para a funcao que testa se o valor inserido é valido
						# e salva a posicao atual
	
	# Caso o valor seja valido (1 < a0 <= 8)
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
	li a7, 4				# a7 = carrega o codigo para printar string
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
indexInput:
	la s6, indexInput
	li a7, 4				# carrega o codigo para printar string
	la a0, msgIndice		# a0 = msgIndice
	ecall					# printa "Digite o indice do valor a ser impresso: "
	li a7, 5				# carrega o codigo para ler inteiro
	ecall					# chamada para ler um inteiro
	
	jal validateIndex		# pula para a funcao que testa se o valor inserido e valido
	
	# Caso o valor inserido seja valido	
	mv s1, a0				# s1 = a0 (s1 recebe o indice logico)
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
	li a7, 10				# finaliza o programa com o codigo 0
   	ecall					# chamada de saida
   	
validateSize:
	mv t3, zero
	# Prmeiro teste: tamanho < 2?
	addi t1, zero, 2 		# t1 = (size < 2)
	blt a0, t1, printError	# se (a0 < 2) printa mensagem de erro e repete o while
	# Segundo teste: tamanho > 8?
	bgt a0, t0, printError	# se (a0 > 8) mostra mensagem de erro e repete o while
	
	jr ra					# Se o valor for valido, volta para a posicao que foi
							# salva antes de vir para o teste de entrada
							
validateIndex:
	addi t3, zero, 1		# t3 = 1 serve para indicar ao printError que ele deve voltar para ca
	# Prmeiro teste: tamanho < 0?
	blt a0, zero, printError # se o valor inserido for < 0, entao mostra mensagem de erro e repete o loop
	# Segundo teste: tamanho > size?
	sub t1, s2, t3			# t1 = size - 1 (reaproveitando o t3)
	bgt a0, t1, printError	# se (a0 > size) mostra mensagem de erro e repete o loop
	jr ra					# Se o valor for valido, volta para a posicao que foi
							# salva antes de vir para o teste de entrada
	
printError:
	li a7, 4				# carrega o codigo de printar strings
	la a0, msgInvalido		# a0 = msgInvalido
	ecall					# "Valor invalido.\n"

	beqz t3, while			# Se t3 == 0 vai para while
	j indexInput			# Se t3 == 1 vai para indexInput