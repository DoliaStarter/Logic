:- use_module(library(assoc)).
insert(Element, 0, Lista, [Element|Lista]).
insert(Element, I, [H|T], [H|NT]) :-
    I > 0,
    NI is I - 1,
    insert(Element, NI, T, NT).
