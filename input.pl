%%% 'input.pl'
%%% predicates for tokenizing input
delete_last_element([_],[]).
delete_last_element([H|T], [H|MinusLast]) :-
  delete_last_element(T, MinusLast).

sentence_atoms_to_lists([],[]).
sentence_atoms_to_lists([SentenceAtom|RestOfSentenceAtoms], [SentenceList|RestOfSentenceLists]) :-
  atomic_list_concat(SentenceList, ' ', SentenceAtom),
  sentence_atoms_to_lists(RestOfSentenceAtoms, RestOfSentenceLists).

sentences_text_to_lists(Text, SentenceLists) :-
  (var(Text)
  -> sentence_atoms_to_lists(SentenceAtomsList, SentenceLists),
  atomic_list_concat(SentenceAtomsList, '. ', TextWithoutPeriod),
  atomic_concat(TextWithoutPeriod, '.', Text)

  ; atomic_list_concat(SentenceAtomsList, '. ', Text),
  last(SentenceAtomsList, LastSentence),
  % Remove period left at end of the last sentence
  atomic_list_concat(LastSentenceWithEmptyAtom, '.', LastSentence),
  delete(LastSentenceWithEmptyAtom, '', CleanedLastSentence),

  % Replace the last sentence with the cleaned, period-less version
  delete_last_element(SentenceAtomsList, SentenceAtomsListWithoutLast),
  append(SentenceAtomsListWithoutLast, CleanedLastSentence, CleanedSentenceAtomsList),
  
  % Tokenize each sentence 
  sentence_atoms_to_lists(CleanedSentenceAtomsList, SentenceLists)
  ).
