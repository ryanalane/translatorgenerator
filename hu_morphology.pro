%%% 'hu_morphology.pro'
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
