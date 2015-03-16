% English lexicon

% lexicon --> dictionary for Nouns and Verbs

en_lex(N_word, n, Features) :- en_dic(N_word, n, Features).

en_lex(V_word, v, V_Features) :- en_dic(V_word, v, V_Features), extract(V_Features, tense:past).

% Adds [num:plur] to root form of verb automatically, as per English grammar rules
en_lex(V_word, v, V_Features) :- en_dic(V_word, v, V_Features1), unify([num:plur],V_Features1, V_Features).
en_lex(V_word, v, [num:sing|V_Features]) :- en_dic(V_word, v, V_Features).

% Determiners
en_lex(the, det, [num:_]).
en_lex(that, det, [num:sing]).
en_lex(those, det, [num:plur]).
en_lex(this, det, [num:sing]).
en_lex(these, det, [num:plur]).

% Nouns
en_dic(boy, n, [pred:boy, num:sing]).
en_dic(boys, n, [pred:boy, num:plur]).
en_dic(cake, n, [pred:cake]).
en_dic(fish, n, [pred:fish]).

% Verbs
en_dic(buy, v, [pred:buy(subj,obj)]).
en_dic(die, v, [pred:die(subj)]).
en_dic(eat, v, [pred:eat(subj, optional(obj))]).
en_dic(sleep, v, [pred:sleep(subj)]).

% Irregular past-tense Verbs
en_lex(bought, v, V_Features) :- en_dic(buy, v, Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
en_lex(slept, v, V_Features) :- en_dic(sleep, v,  Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
