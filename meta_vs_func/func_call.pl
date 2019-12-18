func_call(Action/_/ResultIndex,Arguments,Result):-
    nth1(ResultIndex,L,Result,Arguments),
    Function =.. [Action|L],
    !,
    writeln(Function),
    Function.

func_call(Action/_,Arguments,Result):-
    append(Arguments,[Result],L),
    Function =.. [Action|L],
    Function.


:-op(700,xfx,<#).
:-op(600,xfy, #).
:-op(400,fx,#).


%Result <# Function # ArgsChain :- 
%	parse_args_chain(ArgsChain, Args),
%   func_call(Function, Args, Result).

parse_args_chain(H # T, [H|TArgs]) :- 
    !,
    parse_args_chain(T,TArgs) 
	.
parse_args_chain(H, [H]).

curry_call(Function,Arg,Result):-
    Function =.. [FuncName,Action/ArgCount/ResPos,Args],
    append(Args,[Arg],NewArgs),
    !,
    R is ArgCount - 1,
    (length(NewArgs,R) -> (
        func_call(Action/ArgCount/ResPos,NewArgs,Result));(
        Result =.. [FuncName,Action/ArgCount/ResPos,NewArgs])).

curry_call(Function,Arg,Result):-
    Function =.. [FuncName,Action/ArgCount,Args],
    append(Args,[Arg],NewArgs),
    R is ArgCount - 1,
    (length(NewArgs,R) -> (
        func_call(Action/ArgCount,NewArgs,Result));(
        Result =.. [FuncName,Action/ArgCount,NewArgs])).


Result <# Function # ArgsChain :-
    initial_function(Function, IF),
    curry(IF, ArgsChain, Result).

initial_function(function(F,A), function(F,A)) :-
    !.
initial_function(F, function(F, [])).
                    
curry(F, #T #T2, Result):-
    !,
    F =.. [FuncName,Action,Args],
    MidResult <# T,
    length(Args,L),
    I is L + 1,
    nth1(I,NewArgs,MidResult,Args),   
    NewF =..[FuncName,Action,NewArgs],
    curry(NewF,T2,Result).



curry(F, A # T, Result) :-
    !,
    F =.. [FuncName,Action,Args],
    length(Args,L),
    I is L + 1,
    nth1(I,NewArgs,A,Args),   
    NewF =..[FuncName,Action,NewArgs],
    curry(NewF,T,Result).

curry(F, #T, Result):-
    F =.. [FuncName,Action/ArgCount,Args],
    A <# T,
    length(Args,L),
    I is L + 1,
    nth1(I,NewArgs,A,Args),   
    R is ArgCount - 1,
    (length(NewArgs,R) -> (
        func_call(Action/ArgCount,NewArgs,Result));(
        Result =.. [FuncName,Action/ArgCount,NewArgs])).

curry(F, A, Result) :-
    F =.. [FuncName,Action/ArgCount,Args],
    length(Args,L),
    I is L + 1,
    nth1(I,NewArgs,A,Args),   
    R is ArgCount - 1,
    (length(NewArgs,R) -> (
        func_call(Action/ArgCount,NewArgs,Result));(
        Result =.. [FuncName,Action/ArgCount,NewArgs])).
    