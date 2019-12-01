klucz_mniejszy_od_wartosci(K-V) :- K < V.
ifelse(A,Succ,_):-call(A),!,call(Succ).
ifelse(_,_,Fl):-call(Fl).
include_assoc(_,Dict,Result):-
    		empty_assoc(Dict),
    		list_to_assoc([],Result).
include_assoc(Action,Dict,Result):-
    		min_assoc(Dict,Key,Value),
    		Condition =.. [Action,Key-Value],
    		del_min_assoc(Dict,Key,Value,ErasedDict),
    		include_assoc(Action,ErasedDict,MidResult),
    		ifelse(Condition,put_assoc(Key,MidResult,Value,Result),true).
