# translatorgenerator

# FAQ

1. What's the difference between a "lexical" and "dictionary" entries (i.e., `en_lex()` vs. `en_dic()`)?

Dictionary entries map to the "root" forms of words, such as "speak", "boy".
Lexical entries represent words that have may or may not have morpholgical transformations applied to them. Such as "speak" or "speaks", "boy" or "boys". All forms of valid words will satisfy at least one `lex()` predicate, but only their root forms will satisfy a `dic()` predicate.

This allows root words to be defined, and then their various morphological forms to be recognized or generated via rules. The alternative would be exhaustively listing every form of every valid word, which would quickly become untennable and unnecessarily redundant.
