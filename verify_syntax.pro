% syntax verification predicates
:- reconsult('unify.pro').

complete(Fstruct, Predicate) :- Predicate=..[_|Frame], satisfied(Frame, Fstruct).

satisfied([], _).
satisfied([optional(_)], Fstruct).
satisfied([optional(_)|Rest], Fstruct) :- satisfied(Rest, Fstruct).
satisfied([Case], Fstruct) :- unify([Case:[pred:_]], Fstruct, Fstruct).
satisfied([Case|Rest], Fstruct) :- unify([Case:[pred:_]], Fstruct, Fstruct), satisfied(Rest, Fstruct).
