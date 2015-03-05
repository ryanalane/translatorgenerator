% lexicon for translator

% lexicon --> dictionary for Nouns and Verbs

lex(n, N_word, Features) :- dic(N_word, n, Features).

lex(v, V_word, V_Features) :- dic(V_word, v, V_Features), extract(V_Features, tense:past).

% Adds [num:plur] to root form of verb automatically, as per English grammar rules
lex(v, V_word, V_Features) :- dic(V_word, v, V_Features1), unify([num:plur],V_Features1, V_Features).
lex(v, V_word, [num:sing|V_Features]) :- dic(V_word, v, V_Features).

% lex(det, those, [num:plur]).
lex(det, the, [num:_]).
lex(det, that, [num:sing]).
lex(det, those, [num:plur]).
lex(det, this, [num:sing]).
lex(det, these, [num:plur]).

% Nouns
dic(boy, n, [pred:boy, num:sing]).
dic(boys, n, [pred:boy, num:plur]).
dic(cake, n, [pred:cake]).
dic(fish, n, [pred:fish]).

% Root Verbs
dic(buy, v, [pred:buy(subj,obj)]).
dic(die, v, [pred:die(subj)]).
dic(eat, v, [pred:eat(subj, optional(obj))]).
dic(sleep, v, [pred:sleep(subj)]).

% Past-tense Verbs
dic(bought, v, V_Features) :- dic(buy, v, Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
dic(slept, v, V_Features) :- dic(sleep, v,  Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
