/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Asus
 * Creation Date: 01/12/2018 at 23:16:25
 *********************************************/
 
 
//Par�metros sobre a dimens�o do problema
int n = 7;
int a[i in 1..n] = i;

//In�cio ou fim do fogo
int i_inicio = 1;
int j_inicio = 1;
int i_fim = 7;
int j_fim = 7;


//N�mero de recursos b
int b = 8; 

//Constante de retardamento do fogo por recurso delta
int delta = 8;

//Par�metros sobre os custos dos arcos
int Cima [1..n][1..n] = ...;
int Direita [1..n][1..n] = ...;
int Baixo [1..n][1..n] = ...;
int Esquerda [1..n][1..n] = ...;
int Custos[1..n][1..n][1..n][1..n]; 			//Matriz contendo todos os arcos


//C�digo para preencher a matriz dos custos a partir das outras (extra�das da folha excel)
execute {
for(var x in a)
	for(var xx in a)
		for(var xxx in a)
			for(var xxxx in a)
				Custos[x][xx][xxx][xxxx] = 9999;

  for(var i in a) {
  	for(var j in a) {
		if(i > 1)  	
  	  	  	Custos[i][j][i - 1][j] = Cima[i][j];
  	  	if(i < n)  	
  	  	  	Custos[i][j][i + 1][j] = Baixo[i][j];
  	  	if(j > 1)  	
  	  	  	Custos[i][j][i][j - 1] = Esquerda[i][j];
  	  	if(j < n)  	
  	  	  	Custos[i][j][i][j + 1] = Direita[i][j];  	  	  
  	}  
  }}


//Vari�veis de Decis�o
 dvar float+ T[1..n][1..n];						//Tempo de igni��o de um nodo ij
 dvar boolean R[1..n][1..n];					//Recursos utilizados no nodo ij
 
 //Fun��o Objetivo
 maximize T[i_fim][j_fim];
  
 //Restri��es
 subject to{
  	T[i_inicio][j_inicio] == 0; 
 	forall(i in 1..n, j in 1..n, k in 1..n, l in 1..n: k != i_inicio || l != j_inicio) T[k][l] <= T[i][j] + Custos[i][j][k][l] + R[i][j]*delta;
 	sum(i in 1..n, j in 1..n) R[i][j] <= b;		//S� h� b recursos dispon�veis
 }
 