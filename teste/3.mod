/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Asus
 * Creation Date: 01/12/2018 at 23:16:25
 *********************************************/
 
 
//Par�metros sobre a dimens�o do problema
int n = 7;
int a[i in 1..n] = i;


//N�mero de recursos b
int b = 8;

//Constante de retardamento do fogo por recurso delta
int delta = 8;

//Intervalo de tempo onde minimizar �rea ardida
float time = 12;

//Par�metros sobre os custos dos arcos
int Cima [1..n][1..n] = ...;
int Direita [1..n][1..n] = ...;
int Baixo [1..n][1..n] = ...;
int Esquerda [1..n][1..n] = ...;
int Custos[1..n][1..n][1..n][1..n]; 							//Matriz contendo todos os arcos
float Probs[i in 1..n][j in 1..n] = (14 - i - j)/500;

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
 dvar float+ T[1..n][1..n][1..n][1..n];			//Tempo de um ij para um kl
 dvar boolean R[1..n][1..n];					//Recursos utilizados no nodo ij
 dvar float P[1..n][1..n];
 dvar boolean Arde[1..n][1..n][1..n][1..n];
 
 //Fun��o Objetivo
 minimize sum(i in 1..n, j in 1..n) P[i][j];
  
 //Restri��es
 subject to{
  	forall(i in 1..n, j in 1..n) T[i][j][i][j] == 0;
  	sum(i in 1..n, j in 1..n) R[i][j] <= b;
 	forall(i in 1..n, j in 1..n, k in 1..n, l in 1..n, m in 1..n, n in 1..n) T[i][j][k][l] <= T[i][j][m][n] + Custos[m][n][k][l] + R[m][n]*delta; 	
 	forall(i in 1..n, j in 1..n, k in 1..n, l in 1..n) Arde[i][j][k][l] == (T[i][j][k][l] <= time);
 	forall(i in 1..n, j in 1..n) P[i][j] == Probs[i][j] + sum(k in 1..7, l in 1..7) Arde[k][l][i][j]*((1- Probs[i][j])*Probs[k][l]);
 }