/* Algoritmo de Dijkstra */
/* El siguiente procedimiento encuentra el camino mas corto desde un vértice proporcionado hacia otro vértice de la gráfica. */

/* dijkstra(Vertex0, Ss) es verdadero si Ss es una lista de estructuras, s(Vertex,  */
/* Dist, Path) contiene el camino más corto desde Vertex0 a Vertex, la            */
/* longitud del camino es Dist. El grafo es definido por e/3.                      */
/* por ejemplo dijkstra(penzance, X).                                              */

dijkstra(Vertex, Ss):-
  create(Vertex, [Vertex], Ds),
  dijkstra_1(Ds, [s(Vertex, 0, [])], Ss).

dijkstra_1([], Ss, Ss).
dijkstra_1([D|Ds], Ss0, Ss):-
  best(Ds, D, S),
  delete([D|Ds], [S], Ds1),
  S = s(Vertex, Distance, Path),
  reverse([Vertex|Path], Path1),
  merge(Ss0, [s(Vertex, Distance, Path1)], Ss1),
  create(Vertex, [Vertex|Path], Ds2),
  delete(Ds2, Ss1, Ds3),
  incr(Ds3, Distance, Ds4),
  merge(Ds1, Ds4, Ds5),
  dijkstra_1(Ds5, Ss1, Ss).
 
/* path(Vertex0, Vertex, Path, Dist) es verdadero si el camino es el mas corto      */
/* desde Vertex0 a Vertex, la longitud del camino es Dist.  El grafo está          */
/* definido por e/3.                                                                */
/* por ejemplo path(penzance, london, Path, Dist).                                  */
path(Vertex0, Vertex, Path, Dist):-
  dijkstra(Vertex0, Ss),
  member(s(Vertex, Dist, Path), Ss), !.
 
/* create(Start, Path, Ds) es verdadero si Ds es una lista de estructuras s(Vertex, */
/*  Distance, Path) contiene, para cada Vertex accessible desde el inicio,        */
/*  la Distancia desde el Vertex y el camino específico.  La lista es              */
/*  arreglada por el nombre del Vertex.                                            */
create(Start, Path, Ds):-
  setof(s(Vertex,D,Path), e(Start,Vertex,D), Ds),
  !.
create(_, _, []).

/* best(Ds, D0, D) es verdadero si D es el elementos de Ds, una lista de estructuras*/
/*  s(Vertex, Distance, Path), tiene la distancia pequeña.                        */
/*  D0 constituye un enlace superior.                                              */
best([], Best, Best).
best([D|Ds], Best0, Best):-
  shorter(D, Best0), !,
  best(Ds, D, Best).
best([_|Ds], Best0, Best):-
  best(Ds, Best0, Best).

shorter(s(_, X, _), s(_, Y, _)):-X < Y.

/* delete(Xs, Ys, Zs) es verdadero si Xs, Ys y Zs son listas de estructuras        */
/*  s(Vertex, Distance, Path) es ordenado por Vertex, y Zs es el resultado de      */
/*  eliminar desde Xs los elementosque tengan el mismo Vertex como elementos de Ys.*/
delete([], _, []).
delete([X|Xs], [], [X|Xs]):-!.
delete([X|Xs], [Y|Ys], Ds):-
  eq(X, Y), !,
  delete(Xs, Ys, Ds).
delete([X|Xs], [Y|Ys], [X|Ds]):-
  lt(X, Y), !, delete(Xs, [Y|Ys], Ds).
delete([X|Xs], [_|Ys], Ds):-
  delete([X|Xs], Ys, Ds).
 
/* merge(Xs, Ys, Zs) es verdadero si Zs es el resultado de fusionar Xs y Ys.      */
/* Xs, Ys y Zs son listas de estructuras s(Vertex, Distance, Path), y              */
/* son ordenadas por el Vertex. Si un elementos en Xs tiene el mismo Vertex como  */
/* un elemento en Ys, el elemento que contendrá la distancia más corta estará en Zs*/
merge([], Ys, Ys).
merge([X|Xs], [], [X|Xs]):-!.
merge([X|Xs], [Y|Ys], [X|Zs]):-
  eq(X, Y), shorter(X, Y), !,
  merge(Xs, Ys, Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]):-
  eq(X, Y), !,
  merge(Xs, Ys, Zs).
merge([X|Xs], [Y|Ys], [X|Zs]):-
  lt(X, Y), !,
  merge(Xs, [Y|Ys], Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]):-
  merge([X|Xs], Ys, Zs).

eq(s(X, _, _), s(X, _, _)). 

lt(s(X, _, _), s(Y, _, _)):-X @< Y.

/* incr(Xs, Incr, Ys) es verdadero si Xs y Ys son listras de estructuras          */
/*  s(Vertex, Distance, Path), la sola diferencia en los valores de la distancia */
/*  en Ys es Incr mas que en Xs.                                                */
incr([], _, []). 
incr([s(V, D1, P)|Xs], Incr, [s(V, D2, P)|Ys]):-
  D2 is D1 + Incr,
  incr(Xs, Incr, Ys).

e(X, Y, Z):-dist(X, Y, Z).
e(X, Y, Z):-dist(Y, X, Z).

factorial(N,F):-factorial(N,1,F).
factorial(0,T,T):-!.
factorial(N,T,F):- N1 is N-1,
                  T1 is N*T,
                  factorial(N1,T1,F). 

fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F):- N>1,
                N1 is N-1,
                N2 is N-2,
                fibonacci(N1,F1),
                fibonacci(N2,F2),
                F is F1+F2.