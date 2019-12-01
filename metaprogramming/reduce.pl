dodaj(X,Y,Z) :- Z is X + Y.
reduce(_,[],Acumulator,Acumulator).
reduce(Action,[IH|IT],Acumulator,Result):-
    reduce(Action,IT,Acumulator,MidResult),
    Execute =..[Action,MidResult,IH,Result],
    call(Execute).
                
