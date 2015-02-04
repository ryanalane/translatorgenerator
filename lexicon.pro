% lexicon for translator

% lexicon --> dictionary for Nouns and Verbs

lex(n, N_word, Features) :- dict(N_word, n, N_Features),
                            unify([num:sing], N_Features, Features).

lex(v, V_word, V_Features) :- dic(V_word, v, V_Features), extract(V_Features, tense:past).
lex(v, V_word, V_Features) :- dic(V_word, v, V_Features1), unify([num:plur],V_Features1, V_Features).
lex(v, V_word, [num:sing|V_Features]) :- dic(V_word, v, V_Features).

% lex(det, those, [num:plur]).
lex(det, that, [num:sing]).
lex(det, the, [num:_]).

% Nouns
dic(boy, n, [pred:boy]).
dic(cake, n, [pred:cake]).
dic(fish, n, [pred:fish]).

% Root Verbs
dic(buy, v, [pred:buy(subj,obj)]).
dic(die, v, [pred:die(subj)]).
dic(eat, v, [pred:eat(subj, opt(obj))]).

% Past-tense Verbs
dic(bought, v, V_Features) :- dic(v, vuy, Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
