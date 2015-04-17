%%% 'en_lexicon.pl'
%%% English lexicon

:- reconsult('en_morphology.pl').

% Determiners
% en_dic(Lexeme, det, Lexeme_Det_Features).
en_dic(the, det, [pred:the, num:_]).
en_dic(that, det, [pred:that]).
en_dic(this, det, [pred:this]).

% en_lex(MorphologizedAtom, det, Det_Features).
en_lex(the, det, Det_Features):- en_dic(the, det, Det_Features).
en_lex(that, det, Det_Features):- en_dic(that, det, Lexeme_Det_Features), unify([num:sing], Lexeme_Det_Features, Det_Features).
en_lex(those, det, Det_Features):- en_dic(that, det, Lexeme_Det_Features), unify([num:plur], Lexeme_Det_Features, Det_Features).
en_lex(this, det, Det_Features):- en_dic(this, det, Lexeme_Det_Features), unify([num:sing], Lexeme_Det_Features, Det_Features).
en_lex(these, det, Det_Features):- en_dic(this, det, Lexeme_Det_Features), unify([num:plur], Lexeme_Det_Features, Det_Features).


% Nouns
en_dic(boy, n, [pred:boy], []).
en_dic(coffee, n, [pred:coffee], []).
en_dic(eye, n, [pred:eye], []).
en_dic(table, n, [pred:table], []).

% Match Plural/Singular lexical entries
en_lex(Plural, n, N_Features, Lexeme_Morphology_Features) :-
  en_plur(Plural, Lexeme),
  en_dic(Lexeme, n, Lexeme_N_Features, Lexeme_Morphology_Features),
  unify([num:plur], Lexeme_N_Features, N_Features).

en_lex(Lexeme, n, N_Features, Lexeme_Morphology_Features) :- 
  en_dic(Lexeme, n, Lexeme_N_Features, Lexeme_Morphology_Features),
  unify([num:sing], Lexeme_N_Features, N_Features).

% Root Verbs
en_dic(sleep, v, [pred:sleep(subj)]).
en_dic(stand, v, [pred:stand(subj)]).


% Present-tense Verb conjugations
en_lex(stands, v, V_Features) :-
  en_dic(stand, v,  Root_V_Features),
  unify([num:sing], Root_V_Features, V_Features).


% Past-tense Verbs
en_lex(slept, v, V_Features) :-
  en_dic(sleep, v,  Root_V_Features),
  unify([tense:past], Root_V_Features, V_Features).
