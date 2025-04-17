numero(-10). numero(-5). numero(0).
numero(5). numero(10).

diferencia(N,D,X):- D1 is N-X, 
                    abs(D1,D).
% D es el valor abs de D1

mas_cercano(N,X):- numero(X),
                   diferencia(N,D,X), 
                   not( (numero(X1),
                        diferencia(N,D1,X1),
                        D1<D) ).

sol([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]):- M=1, L=[0,2,3,4,5,6,7,8,9],
                                       select(S,L,L1), S>0, (C3=0;C3=1),
                                       O is C3+S+M-(10*M),
                                       select(O,L1,L2), (C2=0;C2=1),
                                       select(E,L2,L3), N is C2+E+O-(10*C3),
                                       select(N,L3,L4), (C1=0;C1=1),
                                       R is E+(10*C2)-N-C1, 
                                       select(R,L4,L5), select(Y,L5,L6),
                                       D is Y-E+(10*C1), select(D,L6,_). 