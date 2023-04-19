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
		msgVetor2:	.asciz "]: "
		msgIndice:	.asciz "Digite o indice do valor a ser impresso: "
		msgFinal1:	.asciz "O elemento do vetor na posicao "
		msgFinal2: 	.asciz " possui o valor "


	.text
#--------------------- Declaracoes antes de entrar no loop -----------------------------#
	# s0 = endereco do array
	# s1 = indice logico
	# s2 = size
	# s3 = indice fisico (i * 4)
	# s4 = endereco do array[i]
while:
	addi t0, zero, 8 	# t0 = 8 (limite de posicoes)
	li a7, 4			# a7 = codigo para printar string
	la a0, msgInicial	# a0 = msgInicial (endereco)
	ecall				# printa "Entre com o tamanho do vetor (max. = 8): "
	
	li a7, 5			# a7 = codigo para entrar com um inteiro
	ecall
	
	# Prmeiro teste: tamanho < 2?
	slti t1, a0, 2 		# t1 = (size < 2)
	bne t1, zero, while	# se (size < 2) vai para while
	# Segundo teste: tamanho > 8?
	bgt a0, t0, while	# se (i > 8) vai para while
	
exit:
	li a7, 10			# finaliza o programa com o codigo 0
   	ecall				# chamada de saida
		
	
	
	
	
	