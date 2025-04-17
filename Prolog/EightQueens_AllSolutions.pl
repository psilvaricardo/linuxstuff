% Entry point: Finds all possible solutions S for the N-Queens problem
queens(N, S) :-
    make_list(N, L),
    move_safe(L, [], S).

% Helper predicate: Creates a list from N to 1
make_list(0, []).
make_list(N, [N | T]) :-
    N > 0,
    M is N - 1,
    make_list(M, T).

% Recursive backtracking solver: tries to safely place all queens
move_safe([], S, S).
move_safe(L, Qs, S) :-
    select(Q, L, R),
    safe(Q, 1, Qs),
    move_safe(R, [Q | Qs], S).

% Custom select implementation: chooses an element and returns the rest
select(X, [X | T], T).
select(X, [H | T], [H | T1]) :-
    select(X, T, T1).

% Safety check: ensures no two queens attack each other diagonally
safe(_, _, []).
safe(Q, D, [Q1 | Qs]) :-
    Q + D =\= Q1,
    Q - D =\= Q1,
    D1 is D + 1,
    safe(Q, D1, Qs).

% Main procedure to solve and print all solutions for N queens
sol_queens(N) :-
    queens(N, S),
    print_sol(S, 1, N),
    nl,
    fail.  % Force backtracking to find all solutions
sol_queens(_).  % Ensure graceful exit after all solutions

% Print each row of the board
print_sol(_, M, N) :- M > N.
print_sol(S, M, N) :-
    M =< N,
    print_row(M, S),
    M1 is M + 1,
    print_sol(S, M1, N).

% Print a single row: place a 'Q' for the queen, '.' otherwise
print_row(_, []) :- nl.
print_row(M, [Q | Qs]) :-
    ( M = Q -> write(' Q ') ; write(' . ') ),
    print_row(M, Qs).
