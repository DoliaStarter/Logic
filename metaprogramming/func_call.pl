

func_call(Pred,Position,Result):-
   	Pred =.. MidResult,
    insert(Result,Position,MidResult,NewPred),
    Callb =.. NewPred,
    call(Callb).
    
