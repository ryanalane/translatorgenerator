%%% 'hu_lexicon.pro'
%%% Hungarian lexicon


hu_lex(N_word, n, Features) :- hu_dic(N_word, n, Features).
hu_lex(V_word, v, V_Features) :- hu_dic(V_word, v, V_Features), extract(V_Features, tense:past).

% Determiners
hu_lex(az, det, [num:sing]).
hu_lex(azok, det, [num:plur]).
hu_lex(a, det, [num:_]).

% Nouns
hu_dic(fiú, n, [pred:fiú, num:sing]).
hu_dic(fiúk, n, [pred:fiú, num:plur]).
hu_dic(torta, n, [pred:torta]).
hu_dic(hal, n, [pred:hal]).

% Root Verbs
hu_dic(vesz, v, [pred:vesz(subj,obj)]).
hu_dic(meghal, v, [pred:meghal(subj)]).
hu_dic(eszik, v, [pred:eszik(subj, optional(obj))]).
hu_dic(alszik, v, [pred:alszik(subj)]).

% Past-tense Verbs
hu_lex(vett, v, V_Features) :- hu_dic(vesz, v, Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
hu_lex(aludt, v, V_Features) :- hu_dic(alszik, v,  Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
