quitainicio([_|Q],Q).

incertainicio(Q,X,[X|Q]).

quitafinal([_],[]).
quitafinal([X|Q],[X|Q1]):- quitafinal(Q,Q1).

incertafinal([],E,[E]).
incertafinal([X|Q],E,[X|Q1]):- incertafinal(Q,E,Q1).

repite(X,1,[X]).
repite(X,N,[X|Q]):- N>1, N1 is N-1, repite(X,N1,Q).

miembro(X,[X|_]).
miembro(X,[_|Q]):- miembro(X,Q).

selecciona([E|Q],E,Q).
selecciona([X|Q],E,[X|Q1]):- selecciona(Q,E,Q1).

reversa([X],[X]).
reversa([X|Q],LR):- reversa(Q,QR), incertafinal(QR,X,LR).

concatena([],L,L).
concatena([X|Q],L,[X|Q1]):- concatena(Q,L,Q1).