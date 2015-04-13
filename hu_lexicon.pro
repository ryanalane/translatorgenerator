%%% 'hu_lexicon.pro'
%%% Hungarian lexicon

% Determiners
% hu_dic(Lexeme, det, Lexeme_Det_Features, Lexeme_Morphology_Features).
hu_dic(a, det, [pred:a, num:_], []).
hu_dic(az, det, [pred:az], []).
hu_dic(ez, det, [pred:ez], []).
hu_dic(a, helper_det, [], []).

% hu_lex(MorphologizedAtom, det, Det_Features, Det_Morphology_Features).
hu_lex(a, det, Lexeme_Det_Features, Det_Morphology_Features) :-
  hu_dic(a, det, Lexeme_Det_Features, Lexeme_Morphology_Features),
  unify([precedes:consonant], Lexeme_Morphology_Features, Det_Morphology_Features).

hu_lex(az, det, Lexeme_Det_Features, Det_Morphology_Features) :-
  hu_dic(a, det, Lexeme_Det_Features, Lexeme_Morphology_Features),
  unify([precedes:vowel], Lexeme_Morphology_Features, Det_Morphology_Features).

hu_lex(az, det, Det_Features, Lexeme_Morphology_Features) :-
  hu_dic(az, det, Lexeme_Det_Features, Lexeme_Morphology_Features),
  unify([num:sing], Lexeme_Det_Features, Det_Features).

hu_lex(azok, det, Det_Features, Lexeme_Morphology_Features) :-
  hu_dic(az, det, Lexeme_Det_Features, Lexeme_Morphology_Features),
  unify([num:plur], Lexeme_Det_Features, Det_Features).

hu_lex(ez, det, Det_Features, Lexeme_Morphology_Features) :-
  hu_dic(ez, det, Lexeme_Det_Features, Lexeme_Morphology_Features),
  unify([num:sing], Lexeme_Det_Features, Det_Features).

hu_lex(ezek, det, Det_Features, Lexeme_Morphology_Features) :-
  hu_dic(ez, det, Lexeme_Det_Features, Lexeme_Morphology_Features),
  unify([num:plur], Lexeme_Det_Features, Det_Features).

% Helper Determiners
hu_lex(a, helper_det, Lexeme_Det_Features, Det_Morphology_Features) :-
  hu_dic(a, helper_det, Lexeme_Det_Features, Lexeme_Morphology_Features),
  unify([precedes:consonant], Lexeme_Morphology_Features, Det_Morphology_Features).

hu_lex(az, helper_det, Lexeme_Det_Features, Det_Morphology_Features) :-
  hu_dic(a, helper_det, Lexeme_Det_Features, Lexeme_Morphology_Features),
  unify([precedes:vowel], Lexeme_Morphology_Features, Det_Morphology_Features).

% Nouns
% hu_dic(Lexeme, n, N_Features, MorphologyFeatures). 
hu_dic(fiú, n, [pred:fiú], [begin:consonant, end:vowel, harmony:back]).
hu_dic(káve, n, [pred:káve], [begin:consonant, end:vowel_lengthen, harmony:back]).
hu_dic(szem, n, [pred:szem], [begin:consonant, end:consonant, harmony:unrounded]).
hu_dic(asztal, n, [pred:asztal], [begin:vowel, end:consonant, harmony:back]).

%%% Hungarian Morphological Rules
lengthen_ending_vowel(UnlengthenedWord, LengthenedWord):-
  sub_atom(UnlengthenedWord, _, 1, 0, Vowel),
  sub_atom(UnlengthenedWord, 0, _, 1, PartialWord),
  (Vowel=a
  -> atom_concat(PartialWord, á, LengthenedWord)
  ;Vowel=e
  -> atom_concat(PartialWord, é, LengthenedWord)
  ).

% Pluralize Nouns
% Irregular morphology exceptions
hu_plur(halak, hal).

% Plural morphology rules
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, _, MorphologyFeatures),
  extract(MorphologyFeatures, end:vowel),
  atom_concat(Lexeme, 'k', Plural).
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, _, MorphologyFeatures),
  extract(MorphologyFeatures, end:vowel_lengthen),
  lengthen_ending_vowel(Lexeme, LengthenedLexeme),
  atom_concat(LengthenedLexeme, 'k', Plural).
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, _, MorphologyFeatures),
  extract(MorphologyFeatures, end:consonant),
  extract(MorphologyFeatures, harmony:back),
  atom_concat(Lexeme, 'ok', Plural).
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, _, MorphologyFeatures),
  extract(MorphologyFeatures, end:consonant),
  extract(MorphologyFeatures, harmony:unrounded),
  atom_concat(Lexeme, 'ek', Plural).
hu_plur(Plural, Lexeme) :-
  hu_dic(Lexeme, n, _, MorphologyFeatures),
  extract(MorphologyFeatures, end:consonant),
  extract(MorphologyFeatures, harmony:rounded),
  atom_concat(Lexeme, 'ök', Plural).

% Match Plural/Singular lexical entries
hu_lex(Plural, n, N_Features, Lexeme_Morphology_Features) :-
  hu_plur(Plural, Lexeme),
  hu_dic(Lexeme, n, Lexeme_N_Features, Lexeme_Morphology_Features),
  unify([num:plur], Lexeme_N_Features, N_Features).

hu_lex(Lexeme, n, N_Features, Lexeme_Morphology_Features) :- 
  hu_dic(Lexeme, n, Lexeme_N_Features, Lexeme_Morphology_Features),
  unify([num:sing], Lexeme_N_Features, N_Features).

% Root Verbs
hu_dic(alszik, v, [pred:alszik(subj)]).

% Past-tense Verbs
% [person:] feature is only set for person:first or person:second, otherwise third-person is implied
hu_lex(aludt, v, V_Features) :- hu_dic(alszik, v, Root_V_Features),
  unify([tense:past, num:sing], Root_V_Features, V_Features).
hu_lex(aludtak, v, V_Features) :-
  hu_dic(alszik, v, Root_V_Features),
  unify([tense:past, num:plur], Root_V_Features, V_Features).
