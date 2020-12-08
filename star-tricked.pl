% Start Tricked
%
% CECS 342
% Logic Puzzle

ufo(balloon).
ufo(clothesline).
ufo(frisbee).
ufo(water_tower).

person(barrada).
person(gort).
person(klatu).
person(nikto).

day(tuesday).
day(wednesday).
day(thursday).
day(friday).

solve :-
    ufo(BarradaUFO), ufo(GortUFO), ufo(KlatuUFO), ufo(NiktoUFO),
    all_different([BarradaUFO, GortUFO, KlatuUFO, NiktoUFO]),
    
    person(Barrada), person(Gort), person(Klatu), person(Nikto),
    all_different([Barrada, Gort, Klatu, Nikto]),

    Triples = [ [Barrada, BarradaUFO, tuesday],
                [Gort, GortUFO, wednesday],
                [Klatu, KlatuUFO, thursday],
                [Nikto, NiktoUFO, friday] ],

	% 1. Mr. Klatu made his sighting at some point earlier in the week than the
	%    one who saw the balloon, but at some point later in the week than the
	%    one who spotted the frisbee (who isn't Ms. Gort)
	\+(member([klatu, balloon, _], Triples)),
	\+(member([klatu, frisbee, _], Triples)),
	\+(member([gort, frisbee, _], Triples)),
	earlier([klatu, _, _], [_, balloon, _], Triples),
	earlier([_, frisbee, _], [klatu, _, _], Triples),

	% 2. Friday's sighting was made by either Ms. Barrada or the one who saw a clothesline, or both
	(member([barrada, _, friday], Triples) ; 
	 member([_, clothesline, friday], Triples)),

	% 3. Mr. Nikto did not make his sighting on Tuesday
	\+(member([nikto, _, tuesday], Triples)),
   
  % 4. Mr. Klatu isn't the one whose object turned out to be a water tower
  \+(member([klatu, water_tower, _], Triples)),
 
  tell(Barrada, BarradaUFO, tuesday),
  tell(Gort, GortUFO, wednesday),
  tell(Klatu, KlatuUFO, thursday),
  tell(Nikto, NiktoUFO, friday).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
% "!" Represents the Cut, prevents backtracking 
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

% X (head) comes before any element in the tail
earlier(X, _, [X | _]).
% Any element comes before Y when Y is the head should fail and not backtrack.
earlier(_, Y, [Y | _]) :- !, fail.
earlier(X, Y, [_ | Z]) :- earlier(X, Y, Z). 

tell(X, Y, Z) :-
    write(X), write(' saw the '), write(Y), write(' on '), write(Z), write('.'), nl.
