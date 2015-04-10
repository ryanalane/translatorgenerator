sentence_lists_from_strings([], []).
sentence_lists_from_strings([SentenceList|RestOfSentenceLists], [SentenceString|RestOfSentenceStrings]) :-
  atomic_list_concat(SentenceListWithEmptyStrings, ' ', SentenceString),
  delete(SentenceListWithEmptyStrings, '', SentenceList),
  sentence_lists_from_strings(RestOfSentenceLists, RestOfSentenceStrings).

sentences(InputText, SentenceLists) :-
  atomic_list_concat(SentenceStringsListWithEmptyStrings, '.', InputText),
  delete(SentenceStringsListWithEmptyStrings, '', SentenceStringsList),
  sentence_lists_from_strings(SentenceLists, SentenceStringsList).
