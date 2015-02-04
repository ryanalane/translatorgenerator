%%% file "lfg.pro" adapted from "Prolog for Natural Language Processing", Annie Gal, et al., 1991
%%% LFG-like unification grammar
:- reconsult('unify.pro').

% S -> NP(up.subj=down / up.num=down.num), VP(up=down)
s(s_node(NP_node, VP_node), S_Fstruct) --> np(NP_node, NP_Fstruct),
                                { unify([],[subj:NP_Fstruct, num:Num], Partial_Fstruct_1),
                                extract(NP_Fstruct, num:Num) },

                                vp(VP_node, VP_Fstruct),
                                { unify(Partial_Fstruct_1, VP_Fstruct, S_Fstruct),
                                extract(VP_Fstruct, pred:Predicate),
                                complete(S_Fstruct,Predicate) }.


% NP -> Det(up.det=down / up.num=down.num), N(up=down)
np(np_node(Det_node, N_node), NP_Fstruct)  --> det(Det_node, Det_Fstruct),
                                    { unify([], [num:Num,det:Det_Fstruct], Partial_Fstruct_1),
                                    extract(Det_Fstruct, num:Num) },

                                    n(N_node, N_Fstruct),
                                    { unify(Partial_Fstruct_1, N_Fstruct, NP_Fstruct) }.

% VP -> V(up=down), NP(up.obj=down) (transitive verb phrase)
%% TODO: Why is the v_node(V_node) structure repeated (resulting in `v_node(v_node(V), V_Fstruct) --> [V]`)?
% vp(vp_node(v_node(V_node), NP_node), VP_Fstruct) -->

%


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
