%%% interlingua translation example from "Prolog for Natural Language Processing", Annie Gal, et al., 1991
%%% translation based on LFG-like structure

:- reconsult('lfg.pro').
:- reconsult('hu_syntax.pro').
:- reconsult('hu_lexical_pairs.pro').

translate(SourceText, TargetText) :-
    s(_, Source_Fstruct, SourceText,[]),
    lex_translate(Source_Fstruct, Target_Fstruct),
    hu_s(_, Target_Fstruct, TargetText, []).

% translation of lexical entries 
lex_translate([],[]).
lex_translate([pred:SourceWord|SourceRest], [pred:TargetWord|TargetRest]) :-
    lex_pair(SourceWord, TargetWord),
    !,
    lex_translate(SourceRest, TargetRest).
lex_translate([Attribute:SourceValue|SourceRest], [Attribute:TargetValue|TargetRest]) :-
    lex_translate(SourceValue, TargetValue),
    lex_translate(SourceRest, TargetRest).
lex_translate(Value, Value). % the lexical translation has already been processed

