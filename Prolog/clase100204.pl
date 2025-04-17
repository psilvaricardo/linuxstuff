arreglo(1,[x|_],x).
arreglo(I,[_|Q],E):- I>1, 
                     I1 is I-1,
                     arreglo(I1,Q,E).


concatena([],L,L).
concatena([X|Q],L,[X|Q1]):- concatena(Q,L,Q1).

prefijo([],[]).
prefijo(L,W):- concatena(W,_,L).


sufijo([],[]).
sufijo(L,X):- concatena(_,X,L).



sublista(L,L).
sublista(L,SL):- select(_,L,SL).
sublista(L,SL):- seleccionavarios(L,SL).

seleccionavarios(L,SL):- select(_,L,SL1),
                         select(_,SL1,SL2), 
                         sublista(SL2,SL). 


