% run only on Linux PCs:
%
%     use only gprolog.  the command to use is simply ``gprolog''.
%
%     note: On CSIF, gprolog resides in /usr/bin;
%           gprolog assumes that you have that directory in your PATH.
%           if you don't, then
%              in csh or tcsh:
%                 setenv PATH /usr/bin:$PATH
%              in sh, bash, or ksh:
%                 PATH=/usr/bin:$PATH; export PATH
%
%     (this code [should] also works with bp (BinProlog), but don't use that.)


% run all tests via just test.
% or you can run tests for individual parts,
% e.g., test_seq. or just tq. for short.

%
% be sure you have ``consulted'' all files you need to run a particular
% test or tests. And, of course, you'll need to ``consult'' this file too!
%
% the format of each test differs slightly from
% the equivalent interactive test, although it's straightforward to
% extract the interactive test if you want to test something
% individually, as you might during debugging.  roughly:
%  -- remove the ``all'' predicate and any string arguments (e.g., "X" or "Z").
%  -- add parentheses after predicate name.
%  -- put . at end instead of , (if necessary).
% E.g.,
% 	all3( mult, 2,10,Z, "Z"),
% represents
%	mult( 2,10,Z).

% use these predicates to test everything and create Output.your
% then exit from gprolog.
% then compare the correct output with your output.
% e.g.,
%   start up gprolog, consult everything you need, and then type `ty1.'.
%   then exit from gprolog.
%   then:
%     diff Output.correct1 Output.your1
%
%   or:
%    tkdiff Output.correct1 Output.your1
%
% proceed similarly for the other parts.
%
% files should be identical except
%
%   perhaps for the output from the UNSORTED tests of the scheduling
%   predicates.
%   for ONLY those parts, your overall answers should be the same,
%   but the order in which they are generated might differ
%   and you may or may not generate duplicates.

ty :-
	tell('Output.your'), test, told.
% each of these ty predicates tests everything upto and including that part
ty1 :-
	tell('Output.your1'), test_p1, told.
ty2 :-
	tell('Output.your2'), test_p1, test_p2, told.
ty3 :-
	tell('Output.your3'), test_p1, test_p2, test_p3, told.
ty4 :-  % nearly same as ty, except name of output file.
	tell('Output.your4'), test_p1, test_p2, test_p3, test_p4, told.
ty5 :-  % nearly same as ty, except name of output file.
	tell('Output.your5'),
	test_p1, test_p2, test_p3, test_p4, test_p5,
	told.



% test everything
test :-
	test_mach,
	test_seq,
	test_cmember,
	test_sched,
	test_schedwo.

test_p1 :-
	test_mach.
test_p2 :-
	test_seq.
test_p3 :-
	test_cmember.
test_p4 :-
	test_sched.
test_p5 :-
	test_schedwo.

/* some aliases to save typing; see further aliases below for scheduling */
tm :-
	test_mach.
tq :-
	test_seq.
tc :-
	test_cmember.
ts :-
	test_sched.
tw :-
	test_schedwo.

/* define some facts */
mach(lect4,  lect, [joe, sue]).
mach(lect6,  lect, [bob, sue]).
mach(pc4,    pc,   [sue]).
mach(pc11,   pc,   [kim, tom]).
mach(pc18,   pc,   [ann, bob, jim]).
mach(pc22,   pc,   []).
mach(pc24,   pc,   [tom]).
mach(pc31,   pc,   []).
mach(ta7,    ta,   [pat]).

/* note: these variables below are used (due to way test predicates work)
 * but would cause "singleton variable" messages if they only appear once.
 * could use _ here, but prefer to use same name as what's being output.
 * so, we'll make sure each variable below is used at least twice,
 * perhaps by duplicating a given test. ;-)
 */
test_mach :-
	nl, printstring("TESTING M_s"), nl, nl,
	all1( m_names, N, "Name"),
	all1( m_lect, N, "Name"),
	all1( m_pc, N, "Name"),
	all1( m_pc11, U, "Users"),
	all1( m_pc11, U, "Users"),
	all1( m_no, N, "Name"),
	all1( m_eq1, N, "Name"),
	all1( m_ge2, N, "Name").

test_seq :-
	test_myfor,
	test_fib.

test_myfor :-
	nl, printstring("TESTING MYFOR"), nl, nl,
	all3( myfor, 2,10,Z, "Z"),
	all3( myfor, 3,7,Z, "Z"),
	all3( myfor, 3,2,Z, "Z").

test_fib :-
	nl, printstring("TESTING FIB"), nl, nl,
	all4( fib, 2,2,0,Z, "Z"),
	all4( fib, 2,3,10,Z, "Z"),
	all4( fib, 0,1,10,Z, "Z"),
	all4( fib, 1,5,3,Z, "Z"),
	all4( fib, 2,4,2,Z, "Z"),
	all4( fib, 2,2,2,Z, "Z"),
	all4( fib, 2,0,2,Z, "Z"),
	all4( fib, 2,-1,10,Z, "Z"),
	all4( fib, 4,5,18,Z, "Z").

test_cmember :-
	nl, printstring("TESTING CMEMBER"), nl, nl,
	all3( cmember, [ [a,[b,c]],[d,[e,f]]], a, Z, "Z"),
	all3( cmember, [ [a,[b,c]],[d,[e,f]]], e, Z, "Z"),
	all3( cmember, [ [a,[b,c]],[d,[e,f]]], d, Z, "Z"),
	C = [ [30,[9,10]], [40,[11,12]], [50,[33]]],
	all3( cmember, C, 40, Z, "Z"),
	all3( cmember, C, 30, Z, "Z"),
	all3( cmember, C, 99, Z, "Z").

test_sched :-
	test_unsorted_sched(sched),
	test_sorted_sched(sched).

test_schedwo :-
	test_unsorted_sched(schedwo),
	test_sorted_sched(schedwo).

test_unsorted_sched(Which) :-
	nl, printstring("TESTING SCHED (unsorted) "), write(Which), nl, nl,
	C = [[30,[9,10]], [40,[11,12]], [50,[10]]],
	all3( Which, C, [[sue, [30,50]]], Z, "Z"),
	all3( Which, C, [[sue, [30,50]], [joe, [40,30]]], Z, "Z"),
	all3( Which, C, [[sue, []]], Z, "Z"),
	/* above gives [[sue,[]] */
	all3( Which, [[30,[10]], [50,[10]]], [[joe, [30,50]]], Z, "Z"),
	/* above fails w/overlap */
	all3( Which, [ [30,[10]], [40,[11,12]], [50,[10]]],
	             [[sue, [30]], [joe, [30,50]]], Z, "Z"),
	/* above fails w/ overlap (see joe's classes) */
	all3( Which, C, [[joe, [82]]], Z, "Z"),
	/* above fails */
	all3( Which, C, [[sue, []], [joe, [82]]], Z, "Z"),
	/* above fails (any single failure => all fail) */
	all3( Which, C, [[sue, []], [joe, [50]]], Z, "Z"),
	/* above works */
	D = [ [ecs140a,[9]], [ecs140b,[12]],
	      [eng103, [9,10,12]], [nut100, [9,12]], [nut1, [9,12]] ],
	all3( Which, D, [[me, [ecs140a, ecs140b]]], Z, "Z"),
	all3( Which, D,
	             [[me, [ecs140a, ecs140b]], [oops, [ecs150]]], Z, "Z"),
	/* above fails */
	all3( Which, D,
	             [[me, [ecs140a, ecs140b]], [ok, [ecs140a]]], Z, "Z"),
	all3( Which, D,
	             [[me, [ecs140a, ecs140b]], [ok, [eng103]]], Z, "Z"),
	all3( Which, D,
	             [[me, [ecs140a, ecs140b]], [ok, [nut100]]], Z, "Z"),
	all3( Which, D,
	             [[me, [ecs140a, ecs140b]],
	             [ok, [ecs140a,nut100]]],
	             Z, "Z"),
	all3( Which, D,
	             [[me, [ecs140a, ecs140b]],
	             [no, [ecs140a, ecs140b ,nut100]]],
	             Z, "Z"),
	/* above fails w/overlap */
	all3( Which, D,
	             [[ok1, [nut1, nut100]], [ok2, [nut1, nut100]]],
	             Z, "Z").
	
/* same as above, but put all results for a given sched
 * into list and sort that list.
 * your results must match these exactly
 * even if your results for test_sched_unsorted differed (due to ordering).
 */
test_sorted_sched(Which) :-
	nl, printstring("TESTING SCHED (sorted) "), write(Which), nl, nl,
	C = [[30,[9,10]], [40,[11,12]], [50,[10]]],
	sofindall3( Which, C, [[sue, [30,50]]], Z, "Z"),
	sofindall3( Which, C, [[sue, [30,50]], [joe, [40,30]]], Z, "Z"),
	sofindall3( Which, C, [[sue, []]], Z, "Z"),
	/* above gives [[sue,[]] */
	sofindall3( Which, [[30,[10]], [50,[10]]], [[joe, [30,50]]], Z, "Z"),
	/* above fails w/overlap */
	sofindall3( Which, [ [30,[10]], [40,[11,12]], [50,[10]]],
	             [[sue, [30]], [joe, [30,50]]], Z, "Z"),
	/* above fails w/ overlap (see joe's classes) */
	sofindall3( Which, C, [[joe, [82]]], Z, "Z"),
	/* above fails */
	sofindall3( Which, C, [[sue, []], [joe, [82]]], Z, "Z"),
	/* above fails (any single failure => all fail) */
	sofindall3( Which, C, [[sue, []], [joe, [50]]], Z, "Z"),
	/* above works */
	D = [ [ecs140a,[9]], [ecs140b,[12]],
	      [eng103, [9,10,12]], [nut100, [9,12]], [nut1, [9,12]] ],
	sofindall3( Which, D, [[me, [ecs140a, ecs140b]]], Z, "Z"),
	sofindall3( Which, D,
	             [[me, [ecs140a, ecs140b]], [oops, [ecs150]]], Z, "Z"),
	/* above fails */
	sofindall3( Which, D,
	             [[me, [ecs140a, ecs140b]], [ok, [ecs140a]]], Z, "Z"),
	sofindall3( Which, D,
	             [[me, [ecs140a, ecs140b]], [ok, [eng103]]], Z, "Z"),
	sofindall3( Which, D,
	             [[me, [ecs140a, ecs140b]], [ok, [nut100]]], Z, "Z"),
	sofindall3( Which, D,
	             [[me, [ecs140a, ecs140b]],
	             [ok, [ecs140a,nut100]]],
	             Z, "Z"),
	sofindall3( Which, D,
	             [[me, [ecs140a, ecs140b]],
	             [no, [ecs140a, ecs140b ,nut100]]],
	             Z, "Z"),
	/* above fails w/overlap */
	sofindall3( Which, D,
	             [[ok1, [nut1, nut100]], [ok2, [nut1, nut100]]],
	             Z, "Z").
	

/* semi-general tester.
 * run Predicate on A1, A2, A3, A4
 * assume output goes only to A4, whose name is in the string SA4.
 */
all4(Predicate,A1,A2,A3,A4,SA4) :-
	printstring("testing: "), write(Predicate),
	printstring("("), write(A1),
	printstring(","), write(A2),
	printstring(","), write(A3),
	printstring(","), printstring(SA4),
	printstring(")"), nl,
	T =..[Predicate,A1,A2,A3,A4], call(T),
	printstring(SA4), printstring(" = "),
	write(A4), nl, nl,
	fail; true.

/* semi-general tester.
 * run Predicate on A1, A2, A3
 * assume output goes only to A3, whose name is in the string SA3.
 * like all3, but put result in list and sort it.
 */
sofindall3(Predicate,A1,A2,A3,SA3) :-
	printstring("testing: "), write(Predicate),
	printstring("("), write(A1),
	printstring(","), write(A2),
	printstring(","), printstring(SA3),
	printstring(")"), nl,
	T =..[Predicate,A1,A2,A3],
	findall(A3,call(T),L),
	sort(L,SL),
	printstring("SL"), printstring(" = "),
	write(SL), nl, nl,
	fail; true.

/* semi-general tester.
 * run Predicate on A1, A2, A3
 * assume output goes only to A3, whose name is in the string SA3.
 */
all3(Predicate,A1,A2,A3,SA3) :-
	printstring("testing: "), write(Predicate),
	printstring("("), write(A1),
	printstring(","), write(A2),
	printstring(","), printstring(SA3),
	printstring(")"), nl,
	T =..[Predicate,A1,A2,A3], call(T),
	printstring(SA3), printstring(" = "),
	write(A3), nl, nl,
	fail; true.

/* semi-general tester.
 * run Predicate on A1, A2
 * assume output goes A1 and A2, whose names are in the strings SA1 and SA2.
 */
all2(Predicate,A1,SA1,A2,SA2) :-
	printstring("testing: "), write(Predicate),
	printstring("("), printstring(SA1),
	printstring(","), printstring(SA2),
	printstring(")"), nl,
	T =..[Predicate,A1,A2], call(T),
	printstring(SA1), printstring(" = "),
	write(A1), nl,
	printstring(SA2), printstring(" = "),
	write(A2), nl, nl,
	fail; true.
	
/* semi-general tester.
 * run Predicate on A1
 * assume output goes only to A1, whose name is in the string SA1.
 */
all1(Predicate,A1,SA1) :-
	printstring("testing: "), write(Predicate),
	printstring("("), printstring(SA1),
	printstring(")"), nl,
	T =..[Predicate,A1], call(T),
	printstring(SA1), printstring(" = "),
	write(A1), nl, nl,
	fail; true.

/* findall should be standard (pre-defined) predicate,
 * but if not, here it is (from Prolog text).
 */
/****
findall(X,G,_) :-
	asserta(found(mark)),
	call(G),
	asserta(found(X)),
	fail.
findall(_,_,L) :-
	collect_found([],M),
	!,
	L = M.

collect_found(S,L) :-
	getnext(X),
	!,
	collect_found([X|S],L).
collect_found(L,L).

getnext(X) :-
	retract(found(X)),
	!,
	X \== mark.
****/

/* a way to output strings. */
printstring([]).
printstring([H|T]) :- put(H), printstring(T).

% useful to save typing (but mainly for me, not students since they
% will rarely need to reload test.pl within a session) ...
yo :- consult('test.pl').
