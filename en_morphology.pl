%%% 'en_morphology.pl'
%%% English Morphology Rules

% Pluralize Nouns
% Irregular morphology exceptions

% Plural morphology rules
en_plur(Plural, Lexeme) :-
  en_dic(Lexeme, n, _, MorphologyFeatures),
  atom_concat(Lexeme, 's', Plural).
