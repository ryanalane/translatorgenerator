sentence_lists_from_atoms([], []).
sentence_lists_from_atoms([SentenceList|RestOfSentenceLists], [SentenceAtom|RestOfSentenceAtoms]) :-
  atomic_list_concat(SentenceListWithEmptyStrings, ' ', SentenceAtom),
  delete(SentenceListWithEmptyStrings, '', SentenceList),
  sentence_lists_from_atoms(RestOfSentenceLists, RestOfSentenceAtoms).

sentence_atoms_from_lists([],[]).
sentence_atoms_from_lists([SentenceAtom|RestOfSentenceAtoms], [SentenceList|RestOfSentenceLists]) :-
  atomic_list_concat(SentenceList, ' ', SentenceAtomWithoutPeriod),
  atom_concat(SentenceAtomWithoutPeriod, '.', SentenceAtom),
  sentence_atoms_from_lists(RestOfSentenceAtoms, RestOfSentenceLists).

sentences_lists_from_text(SentenceLists, InputText) :-
  atomic_list_concat(SentenceStringsListWithEmptyStrings, '.', InputText),
  delete(SentenceStringsListWithEmptyStrings, '', SentenceStringsList),
  sentence_lists_from_atoms(SentenceLists, SentenceStringsList).

sentences_text_from_lists(InputText, SentenceLists) :-
  sentence_atoms_from_lists(SentenceAtomsList, SentenceLists),
  atomic_list_concat(SentenceAtomsList, ' ', InputText).
