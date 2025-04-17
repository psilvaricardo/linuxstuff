% Entry point: Generates a solution S for the N-Queens problem
queens(N, S) :-
    make_list(N, L),        % Create a list of numbers from N down to 1 (representing rows)
    move_safe(L, [], S).    % Attempt to place queens in safe positions recursively

% Helper predicate: Creates a list from N to 1
make_list(0, []).
make_list(N, [N | T]) :-
    N > 0,
    M is N - 1,
    make_list(M, T).

% Recursive backtracking solver: tries to safely place all queens
move_safe([], S, S).  % Base case: no more queens to place, return current solution
move_safe(L, Qs, S) :-
    select(Q, L, R),         % Select a queen (row position) from list L
    safe(Q, 1, Qs),          % Check if placing Q is safe with respect to already placed queens
    move_safe(R, [Q | Qs], S).  % Continue with the remaining queens

% Custom select implementation: chooses an element and returns the rest
select(X, [X | T], T).
select(X, [H | T], [H | T1]) :-
    select(X, T, T1).

% Safety check: ensures no two queens attack each other diagonally
safe(_, _, []).  % No queens left to compare, it's safe
safe(Q, D, [Q1 | Qs]) :-
    Q + D =\= Q1,   % Check major diagonal
    Q - D =\= Q1,   % Check minor diagonal
    D1 is D + 1,    % Increment distance for next queen
    safe(Q, D1, Qs).

% Main procedure to solve and print the solution for N queens
sol_queens(N) :-
    queens(N, S),        % Generate a solution
    print_sol(S, 1, N).  % Print the board representation

% Print each row of the board
print_sol(_, M, N) :- M > N.  % All rows printed
print_sol(S, M, N) :-
    M =< N,
    print_row(M, S),      % Print current row
    M1 is M + 1,
    print_sol(S, M1, N).

% Print a single row: place a 'Q' for the queen, '.' otherwise
print_row(_, []) :- nl.  % End of row, go to next line
print_row(M, [Q | Qs]) :-
    ( M = Q -> write(' Q ') ; write(' . ') ),  % Place queen or dot
    print_row(M, Qs).
