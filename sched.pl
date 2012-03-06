/* PART 1 */

/* all machine names */
m_names(X) :-
    mach(X,_,_).

/* names of all lect machines */
m_lect(Name) :-
    mach(Name, lect,_).

/* names of all pc machines */
m_pc(Name) :-
    mach(Name,pc,_).

/* users on pc11 */
m_pc11(Name) :-
    mach(pc11,pc,Name).

/* names of machines with no users */
m_no(Name) :-
    mach(Name,_,[]).

/* exactly one user */
m_eq1(Name) :-
    mach(Name,_,L1),
    length(L1,1).

/* at least two users */
m_ge2(Name) :-
    mach(Name,_,L1),
    length(L1,N1),
    N1>=2.

/*===================================*/

/* PART 2 */

/* myfor */
myfor(First,Last,Result) :-
    (
    First>Last,
    Result = []
    );
    (
    First=<Last,
    N1 is First+1,
    myfor(N1,Last,L1),
    Result = [First|L1]
    ).

/* fib sequence */
fib(First1,First2,Last,Result) :-
    (
    First1==Last ->
    Result = [First1]
    ;
    First1=<Last,
    First2>Last ->
    Result = [First1]
    ;
    First1>Last ->
    Result = []
    ;
    First1==Last,
    First2==Last ->
    Result = [First1]
    ;
    First1=<Last,
    First2=<Last ->
    S1 is First1+First2,
    S2 is First1+First2+First2,
    fib(S1,S2,Last,R1),
    Result = [First1,First2|R1]
    ).






