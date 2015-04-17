% feature extraction predicates
extract([], Feature:Value) :- !,fail.
extract([Feature:Value|_], Feature:Value).
extract([Feature1:Value1|Rest], Feature2:Value2) :- extract(Rest, Feature2:Value2).
