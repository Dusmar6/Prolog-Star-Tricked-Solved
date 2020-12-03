% "Star Tricked.pl"
%
% CECS 342
% Logic Puzzle

person(ms_barrada).
person(ms_gort).
person(mr_klatu).
person(mr_nikto).

object(balloon).
object(clothesline).
object(frisbee).
object(water_tower).

% Solve the puzzle.
solve :-
    object(TuesObject), object(WedObject), object(ThursObject), object(FriObject),
    all_different([TuesObject, WedObject, ThursObject, FriObject]),
    
    person(TuesPerson), person(WedPerson), person(ThursPerson), person(FriPerson),
    all_different([TuesPerson, WedPerson, ThursPerson, FriPerson]),
    
    Triples = [ [TuesPerson, TuesObject, tuesday],
                [WedPerson, WedObject, wednesday],
                [ThursPerson, ThursObject, thursday],
                [FriPerson, FriObject, friday] ],

    % 1. Mr. Klatu made his sighting at some point earlier 
    % in the week than the one who saw the balloon, but
    % at some point later in the week than the one who
    % spotted the Frisbee (who isn't Ms. Gort).
    \+(member([mr_klatu, balloon, _], Triples)), % Klatu not balloon
    \+(member([mr_klatu, frisbee, _], Triples)), % Klatu not frisbee
    \+(member([ms_gort, frisbee, _], Triples)), % Gort not frisbee
    
    % Not sure how to do this (this is incorrect)
    earlier(member([mr_klatu, _, _], Triples), member([_, balloon, _], Triples)), % Klatu before balloon
    earlier(member([_, frisbee, _], Triples), member([mr_klatu, _, _], Triples)), % frisbee before Klatu

    % 2. Friday's sighting was made by either Ms. Barrada 
    % or the one who saw a clothesline (or both).
    ( member([ms_barrada, _, friday], Triples) ; % Barada maybe Friday OR
      member([_, clothesline, friday], Triples) ), % whoever saw clothesline

    % 3. Mr. Nikto did not make his sighting on Tuesday.
    \+(member([mr_nikto, _, tuesday], Triples)), % Nikto not Tuesday

    % 4. Mr. Klatu isn't the one whose object turned out to be a water tower.
    \+(member([mr_klatu, water_tower, _], Triples)),  % Klatu not water tower

    tell(TuesPerson, TuesObject, tuesday),
    tell(WedPerson, WedObject, wednesday),
    tell(ThursPerson, ThursObject, thursday),
    tell(FriPerson, FriObject, friday).

% Succeed if all elements of the argument list are bound and different.
% Fail if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.        
all_different([_ | T]) :- all_different(T).            
all_different([_]).                                     

% Not sure how to do this (this is incorrect)
before(tuesday, wednesday).
before(wednesday, thursday).
before(thursday, friday).
earlier(X, X).
earlier(X, Y) :- before(Z, Y), before(Z, X).

% Write out an English sentence with the solution.
tell(X, Y, Z) :-
	write(X), write(' saw a '), write(Y), write(' on '), write(Z), write('.'), nl.