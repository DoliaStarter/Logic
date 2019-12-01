:- dynamic query/1.
findall_assoc(SearchGoal,Action,Result):-
    forall(call(Action),
           (
    		assert(query(SearchGoal-t))
           )),
    findall(SearchGoal-t,retract(query(SearchGoal-t)),List),
    list_to_assoc(List,Result).
