minOfTwo(X, Y, Y) :- X >= Y.
minOfTwo(X, Y, X) :- X < Y.

minList([], 0).
minList([H], H).
minList([H|T], R) :- minList(T, R2), minOfTwo(H, R2, R).

% reverse a list using an accumulator variable
revLst([], C, C).
revLst([H|T], C, R) :- C2 = [H|C], revLst(T, C2, R).

% Counts the number of times Element appears in List
% noElems(List, Element, Result)
% noElems(i, i, o)
noElems([], _, 0).
noElems([H|T], E, R) :- H =\= E, noElems(T, E, R).
noElems([H|T], E, R) :- H =:= E, noElems(T, E, R2), R is R2 + 1.

% noElems with an accumulator variable
noElems2([], _, C, C).
noElems2([H|T], E, C, R) :- H =:= E, C2 is C + 1, noElems2(T, E, C2, R).
noElems2([_|T], E, C, R) :- noElems2(T, E, C, R).

% [2, 3, 4, 2] -> [2, 3, 4]
makeSet([], []).
makeSet([H|T], R) :- noElems([H|T], H, HCNT), HCNT > 1, makeSet(T, R).
makeSet([H|T], R) :- noElems([H|T], H, HCNT), HCNT =:= 1, makeSet(T, R2), R = [H|R2].

% using an accumulator variable
makeSet2([], C, C).
makeSet2([H|T], C, R) :- noElems([H|T], H, HCNT), HCNT =:= 1, C2 = [H|C], makeSet2(T, C2, R).
makeSet2([_|T], C, R) :- makeSet2(T, C, R).

% same as remove max val
removeEl([], _, []).
removeEl([H|T], E, R) :- H =:= E, removeEl(T, E, R).
removeEl([H|T], E, R) :- H =\= E, removeEl(T, E, R2), R = [H|R2].

% does not remove all occurences of E, only the first one
removeSingleEl([], _, []).
removeSingleEl([H|T], E, T) :- H =:= E.
removeSingleEl([H|T], E, R) :- removeSingleEl(T, E, R2), R = [H|R2].

% removeEl using an accumulator variable
% apelez revLst pentru ca [1,2,3,4] ar returna [4,3,2]
% iar eu vreau arrayul original
removeAcc([], _, C, R) :- revLst(C, [], C2), R = C2.
removeAcc([H|T], E, C, R) :- H =:= E, removeAcc(T, E, C, R).
removeAcc([H|T], E, C, R) :- C2 = [H|C], removeAcc(T, E, C2, R).

% this already removes duplicates without needing to call pointA
% (because removeEl removes all occurences of an element in a list)
sortInc([], []).
sortInc([H|T], R) :- minList([H|T], MINEL), removeEl([H|T], MINEL, NEWLST), sortInc(NEWLST, R2), R = [MINEL|R2].

% nu merge
sortInc2([], C, C).
sortInc2([H|T], C, R) :- minList([H|T], MINEL), removeEl([H|T], MINEL, NEWLST), sortInc2(NEWLST, C2, R), C = [MINEL|C2].

%sortInc keep double values in place
% [4,2,6,2,3,4] -> [2,2,3,4,4,6]
sortInc3([], []).
sortInc3([H|T], R) :- minList([H|T], MINEL), removeSingleEl([H|T], MINEL, NEWLST), sortInc3(NEWLST, R2), R = [MINEL|R2].

% sum of elements of a list using an input variable
sumLst([], C, C).
sumLst([H|T], C, R) :- C2 is C + H, sumLst(T, C2, R).


% 123 -> 321
% fara variabila colectoare
% nu merge
inv(0, 0).
inv(N, R) :- NMOD is N mod 10, NDIV is N div 10, inv(NDIV, R2), R2 is R * 10 + NMOD.

% 123 -> 321
% cu variabila colectoare
inv2(0, C, C).
inv2(N, C, R) :- NMOD is N mod 10, NDIV is N div 10, C2 is C * 10 + NMOD, inv2(NDIV, C2, R).

% merge two sorted lists
mergeLists([], [], []).
mergeLists(LST1, [], LST1).
mergeLists([], LST2, LST2).
mergeLists([H|T], [H2|T2], R) :- H =< H2, mergeLists(T, [H2|T2], R2), R = [H|R2].
mergeLists([H|T], [H2|T2], R) :- H > H2, mergeLists(T, T2, R2), R = [H2|R2].
