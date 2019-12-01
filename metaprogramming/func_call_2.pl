place_last(Element,[],[Element]).
place_last(Element,[H|T],[H|MidResult]):-
    place_last(Element,T,MidResult).
func_call(Action,Result):-
    Action =.. Query,
    place_last(Result,Query,NewQuery), 
    NewAction =.. NewQuery ,
    NewAction.
 
