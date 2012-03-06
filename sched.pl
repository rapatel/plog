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


/*===================================*/

/* PART 3 */

cmember(C,X,Y) :-
    member([X|T],C),
    Y = [X|T].

/*===================================*/

/* PART 4 */

% Sorts each students classes
sclass([],[]).
sclass(C,L) :-
    [F|T] = C,
    [S|T2] = F,
    [Cl|_] = T2,
    sort(Cl,Sorted),
    sclass(T,L2),
    L3 = [S,Sorted],
    L = [L3|L2].

% Created a schedule for the student
fsched([],_,[]).
fsched(Courses,CList,R) :-
    [C1|T] = Courses,
    fsched(T,CList,R2),
    cmember(CList,C1,Time),
    [_|T2] = Time,
    [Cltime|_] = T2,    
    member(Atime,Cltime),
    X = [C1,Atime],
    R = [X|R2].

sched(_,[],[]).
sched(C,S,Z) :-
    sort(C,C2),
    sort(S,S2),
    sclass(S2,Ssorted),
    [St1|Rest] = Ssorted,
    sched(C2,Rest,Sch2),
    [Stname|T] = St1,
    [Stcourses|_] = T,
    fsched(Stcourses,C2,Sch1),
    Stsched = [Stname,Sch1],
    Z = [Stsched|Sch2].

















