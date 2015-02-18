%%% 'hu_lexicon.pro'
%%% Hungarian lexicon

% lexicon --> dictionary for Nouns and Verbs

hu_lex(n, N_word, Features) :- hu_dic(N_word, n, N_Features),
                            unify([num:sing], N_Features, Features).

hu_lex(v, V_word, V_Features) :- hu_dic(V_word, v, V_Features), extract(V_Features, tense:past).

hu_lex(det, az, [num:sing]).
hu_lex(det, a, [num:_]).

% Nouns
hu_dic(fiú, n, [pred:fiú]).
hu_dic(torta, n, [pred:torta]).
hu_dic(hal, n, [pred:hal]).

% Root Verbs
hu_dic(vesz, v, [pred:vesz(subj,obj)]).
hu_dic(meghal, v, [pred:meghal(subj)]).
hu_dic(eszik, v, [pred:eszik(subj, optional(obj))]).
hu_dic(alszik, v, [pred:alszik(subj)]).

% Past-tense Verbs
hu_dic(vett, v, V_Features) :- hu_dic(vesz, v, Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
hu_dic(aludt, v, V_Features) :- hu_dic(alszik, v,  Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
