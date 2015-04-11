%%% interlingua translation example from "Prolog for Natural Language Processing", Annie Gal, et al., 1991
%%% translation based on LFG-like structure

:- reconsult('input.pro').
:- reconsult('en_syntax.pro').
:- reconsult('hu_syntax.pro').
:- reconsult('en-hu_lexical_pairs.pro').

translate(SourceText, TargetText) :-
  (var(SourceText)
  -> sentences_text_to_lists(TargetText, TargetSentences),
  translate_sentences(SourceSentences, TargetSentences),
  sentences_text_to_lists(SourceText, SourceSentences)
  ; sentences_text_to_lists(SourceText, SourceSentences),
  translate_sentences(SourceSentences, TargetSentences),
  sentences_text_to_lists(TargetText, TargetSentences)
  ).

translate_sentences([],[]).
translate_sentences([SourceSentence|RestOfSourceSentences], [TargetSentence|RestOfTargetSentences]) :-
    en_s(_, Source_Fstruct, SourceSentence,[]),
    lex_translate(Source_Fstruct, Target_Fstruct),
    hu_s(_, Target_Fstruct, TargetSentence, []),
    translate_sentences(RestOfSourceSentences,RestOfTargetSentences).

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

