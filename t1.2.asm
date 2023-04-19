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
#	while (tamanho < 1 || tamanho > 8){
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
	.text
main: