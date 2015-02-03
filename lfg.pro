%%% file "lfg.pro" adapted from "Prolog for Natural Language Processing", Annie Gal, et al., 1991
%%% LFG-like unification grammar
:- reconsult('unify.pro').

% S -> NP(up.subj=down / up.num=down.num), VP(up=down)
s(s_node(NP,VP), S_Fstruct) --> np(NP_node, NP_Fstruct),
                                { unify([],[subj:NP_Fstruct, num:Num], Partial_Fstruct_1),
                                extract(NP_Fstruct, num:Num) },

                                vp(VP_node, VP_Fstruct),
                                { unify(Partial_Fstruct_1, VP_Fstruct, S_Fstruct),
                                extract(VP_Fstruct, pred:Predicate),
                                complete(S_Fstruct,Predicate) }.


% auxilary predicates

extract([], Feature:Value) :- !,fail.
extract([Feature:Value|_], Feature:Value).
extract([Feature1:Value1|Rest], Feature2:Value2) :- extract(Rest, Feature2:Value2).

complete(Fstruct, Predicate) :- Predicate=..[_|Frame], satisfied(Frame, F).

satisfied([], _).
satisfied([opt(_)], Fstruct).
satisfied([opt(_)|Rest], Fstruct) :- satisfied(Rest, Fstruct).
satisfied([Case], Fstruct) :- unify([Case:[pred:_]], Fstruct, Fstruct).
satisfied([Case|Rest], Fstruct) :- unify([Case:[pred:_]], Fstruct, Fstruct), satisfied(Rest, Fstruct).
