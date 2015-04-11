%%% 'hu_lexicon.pro'
%%% Hungarian lexicon


hu_lex(V_word, v, V_Features) :- hu_dic(V_word, v, V_Features), extract(V_Features, tense:past).

% Determiners
hu_lex(az, det, [num:sing]).
hu_lex(azok, det, [num:plur]).
hu_lex(a, det, [num:_]).

% Nouns
hu_dic(fiú, n, [pred:fiú, begin:consonant, end:vowel, harmony:back]).
hu_dic(torta, n, [pred:torta, begin:consonant, end:vowel_lengthen, harmony:back]).
hu_dic(hal, n, [pred:hal, begin:consonant, end:consonant, harmony:back]).
hu_dic(szemüveg, n, [pred:szemüveg, begin:consonant, end:consonant, harmony:unrounded]).

%% Hungarian Morphological Rules
lengthen_ending_vowel(UnlengthenedWord, LengthenedWord):-
  sub_atom(UnlengthenedWord, _, 1, 0, Vowel),
  sub_atom(UnlengthenedWord, 0, _, 1, PartialWord),
  (Vowel=a
  -> atom_concat(PartialWord, á, LengthenedWord)
  ;Vowel=e
  -> atom_concat(PartialWord, é, LengthenedWord)
  ).

% Pluralize Nouns
% Plural morphology exceptions
hu_plur(halak, hal).

% Plural morphology rules
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, Lexeme_N_Features),
  extract(Lexeme_N_Features, end:vowel),
  atom_concat(Lexeme, 'k', Plural).
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, Lexeme_N_Features),
  extract(Lexeme_N_Features, end:vowel_lengthen),
  lengthen_ending_vowel(Lexeme, LengthenedLexeme),
  atom_concat(LengthenedLexeme, 'k', Plural).
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, Lexeme_N_Features),
  extract(Lexeme_N_Features, end:consonant),
  extract(Lexeme_N_Features, harmony:back),
  atom_concat(Lexeme, 'ok', Plural).
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, Lexeme_N_Features),
  extract(Lexeme_N_Features, end:consonant),
  extract(Lexeme_N_Features, harmony:unrounded),
  atom_concat(Lexeme, 'ek', Plural).
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, Lexeme_N_Features),
  extract(Lexeme_N_Features, end:consonant),
  extract(Lexeme_N_Features, harmony:rounded),
  atom_concat(Lexeme, 'ök', Plural).

% Match Plural/Singular lexical entries
hu_lex(Plural, n, N_Features) :-
  hu_plur(Plural, Lexeme),
  hu_dic(Lexeme, n, Lexeme_N_Features),
  unify([num:plur], Lexeme_N_Features, N_Features).

hu_lex(Lexeme, n, N_Features) :- 
  hu_dic(Lexeme, n, Lexeme_N_Features),
  unify([num:sing], Lexeme_N_Features, N_Features).

% Root Verbs
hu_dic(vesz, v, [pred:vesz(subj,obj)]).
hu_dic(meghal, v, [pred:meghal(subj)]).
hu_dic(eszik, v, [pred:eszik(subj, optional(obj))]).
hu_dic(alszik, v, [pred:alszik(subj)]).

% Past-tense Verbs
hu_lex(vett, v, V_Features) :- hu_dic(vesz, v, Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
hu_lex(aludt, v, V_Features) :- hu_dic(alszik, v, Root_V_Features), unify([tense:past], Root_V_Features, V_Features).
