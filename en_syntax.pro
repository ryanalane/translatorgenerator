%%% English syntax
%%% adapted from file "lfg.pro" from "Prolog for Natural Language Processing", Annie Gal, et al., 1991
%%% LFG-like unification grammar

% S -> NP(up.subj=down / up.num=down.num), VP(up=down)
en_s(s_node(NP_node, VP_node), S_Fstruct) --> en_np(NP_node, NP_Fstruct),
                                { unify([],[subj:NP_Fstruct, num:Num], Partial_Fstruct_1),
                                extract(NP_Fstruct, num:Num) },

                                en_vp(VP_node, VP_Fstruct),
                                { unify(Partial_Fstruct_1, VP_Fstruct, S_Fstruct),
                                extract(VP_Fstruct, pred:Predicate),
                                complete(S_Fstruct, Predicate) }.


% NP -> Det(up.det=down / up.num=down.num), N(up=down)
en_np(np_node(Det_node, N_node), NP_Fstruct)  --> en_det(Det_node, Det_Fstruct),
                                    { unify([], [num:Num,det:Det_Fstruct], Partial_Fstruct_1),
                                    extract(Det_Fstruct, num:Num) },

                                    en_n(N_node, N_Fstruct),
                                    { unify(Partial_Fstruct_1, N_Fstruct, NP_Fstruct) }.

% VP -> V(up=down), NP(up.obj=down) (transitive verb phrase)
% en_vp(vp_node(v_node(V_node), NP_node), VP_Fstruct) -->

% VP -> V(up=down) (intransitive verb phrase)
en_vp(vp_node(v_node(V_node)), VP_Fstruct) --> en_v(V_node, VP_Fstruct).

% rules for terminal symbols
en_n(n_node(N_word), N_Fstruct) --> [N_word], { en_lex(N_word, n, N_Fstruct) }.
en_v(v_node(V_word), V_Fstruct) --> [V_word], { en_lex(V_word, v, V_Fstruct) }.
en_det(det_node(D_word), D_Fstruct) --> [D_word], { en_lex(D_word, det, D_Fstruct) }.

% English lexicon
:- reconsult('en_lexicon.pro').

% syntax verification predicates
:- reconsult('verify_syntax.pro').

% feature list unification
:- reconsult('unify.pro').

% feature extraction
:- reconsult('extract.pro').
