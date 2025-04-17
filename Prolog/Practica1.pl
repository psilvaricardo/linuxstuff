% PLASCENCIA SILVA JUAN RICARDO DE JESUS
% TALLER DE PROGRAMACION LOGICA Y FUNCIONAL
% PRACTICA #1

% DADO UN SISTEMA DE UNA MATRIZ A Y DOS VECTORES x y b,
% DE LA FORMA Ax=b, ENCONTRAR LA(S) SOLUCION(ES) DEL 
% SISTEMA DADAS A y B. 

longitud([],0).
longitud([_|Q],N):- longitud(Q,N1), 
                    N is N1+1.

identidad([[]]).
identidad([X|Q]):- unidad(X),
                   reduce(Q|Q1),
		   identidad(Q1).

unidad([1|Q]):-	ceros(Q).

ceros([[]]).
ceros([0|Q]):- ceros(Q).

reduce([[0]],[[]]).
reduce([[0|R]|Q],[R,Z]):- reduce(Q,Z).

solucion(A,X,B):- resuelve(A,X,B).

resuelve(A,B,B):- identidad(A).
resuelve(A,X,B):- minima(A,A1,B,B1),resuelve(A1,X,B1).

minima().