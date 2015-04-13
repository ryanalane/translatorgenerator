% English lexicon

% lexicon --> dictionary for Nouns and Verbs

en_lex(N_word, n, Features) :- en_dic(N_word, n, Features).

en_lex(V_word, v, V_Features) :- en_dic(V_word, v, V_Features), extract(V_Features, tense:past).

% Adds [num:plur] to root form of verb automatically, as per English grammar rules
en_lex(V_word, v, V_Features) :- en_dic(V_word, v, V_Features1), unify([num:plur],V_Features1, V_Features).
en_lex(V_word, v, [num:sing|V_Features]) :- en_dic(V_word, v, V_Features).

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
en_dic(boy, n, [pred:boy, num:sing]).
en_dic(boys, n, [pred:boy, num:plur]).
en_dic(cake, n, [pred:cake, num:sing]).
en_dic(cakes, n, [pred:cake, num:plur]).
en_dic(eye, n, [pred:eye, num:sing]).
en_dic(table, n, [pred:table, num:sing]).
en_dic(tables, n, [pred:table, num:plur]).

% Verbs
en_dic(sleep, v, [pred:sleep(subj)]).

% Irregular past-tense Verbs
en_lex(slept, v, V_Features) :-
  en_dic(sleep, v,  Root_V_Features),
  unify([tense:past], Root_V_Features, V_Features).
