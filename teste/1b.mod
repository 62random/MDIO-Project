/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Asus
 * Creation Date: 07/12/2018 at 12:22:04
 *********************************************/
 
//Par�metros sobre a dimens�o do problema
int n = 7;
int a[i in 1..n] = i;

//In�cio ou fim do fogo
int i_inicio = 1;
int j_inicio = 1;



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
dvar int+ T[1..n][1..n];						//Tempo de igni��o de um nodo ij
 
 
 //Fun��o Objetivo
 maximize sum(i in 1..n, j in 1..n)  T[i][j];
  
 //Restri��es
 subject to{
 	forall(i in 1..n, j in 1..n, k in 1..n, l in 1..n: k != 1 || l != 1) T[k][l] <= T[i][j] + Custos[i][j][k][l];
 	T[i_inicio][j_inicio] == 0;	
 }