%%% general unification procedure from 'Prolog for Natural Language Processing", Annie Gal, et al., 1991

%%% feature-value pairs are indicated by ':'
%%% F:V1 unifies with F:V@ if V1=V2 or V1 and V2 are sets and V1 unifies with V2 (i.e., this procedure handles recursive unification


%%% call X=[f1:v2,f2:v2], Y=[f2:v2,f3:v3], unify(X,Y,Z).
%%% result Z=[f1:v1,f2:v2,f3:v3]

%%% two sets of features can be unified iff all features that the sets have in common have unifiable values
:-op(600,xfy,':').

unify(Featureset,Featureset,Featureset) :-!. % identical sets
unify(Anything,[],Anything) :-!.
unify([],Anything,Anything) :-!.

% same feature same value
unify([Feature1:Value1|Rest1],[Feature1:Value1|Rest2],[Feature1:Value1|Result]) :- !, unify(Rest1,Rest2,Result).

% same feature setvalue
unify([Feature1:SetValue1|Rest1],[Feature1:SetValue2|Rest2],[Feature1:Result1|Result]) :- not(atom(SetValue1)), not(atom(SetValue)), unify(SetValue1,SetValue2,Result1), unify(Rest1,Rest2,Result), !.

% same feature different value
unify([Feature1:Value1|Rest1],[Feature1:Value2|Rest2],Result) :- !, fail.
