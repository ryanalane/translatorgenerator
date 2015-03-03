%%% 'hu_syntax.pro'
%%% LFG-like unification grammar for Hungarian
:- reconsult('unify.pro').
:- reconsult('hu_lexicon.pro').

% S -> NP(up.subj=down / up.num=down.num), VP(up=down)
hu_s(s_node(NP_node, VP_node), S_Fstruct) --> hu_np(NP_node, NP_Fstruct),
                                { unify([],[subj:NP_Fstruct, num:Num], Partial_Fstruct_1),
                                extract(NP_Fstruct, num:Num) },

                                hu_vp(VP_node, VP_Fstruct),
                                { unify(Partial_Fstruct_1, VP_Fstruct, S_Fstruct),
                                extract(VP_Fstruct, pred:Predicate),
                                complete(S_Fstruct, Predicate) }.


% NP -> Det(up.det=down / up.num=down.num), N(up=down)
hu_np(np_node(Det_node, N_node), NP_Fstruct)  --> hu_det(Det_node, Det_Fstruct),
                                    { unify([], [num:Num,det:Det_Fstruct], Partial_Fstruct_1),
                                    extract(Det_Fstruct, num:Num) },

                                    hu_n(N_node, N_Fstruct),
                                    { unify(Partial_Fstruct_1, N_Fstruct, NP_Fstruct) }.

% VP -> V(up=down) (intransitive verb phrase)
hu_vp(vp_node(v_node(V_node)), VP_Fstruct) --> hu_v(V_node, VP_Fstruct).

% rules for terminal symbols
hu_n(n_node(N_word), N_Fstruct) --> [N_word], { hu_lex(n, N_word, N_Fstruct) }.
hu_v(v_node(V_word), V_Fstruct) --> [V_word], { hu_lex(v, V_word, V_Fstruct) }.
hu_det(det_node(D_word), D_Fstruct) --> [D_word], { hu_lex(det, D_word, D_Fstruct) }.
