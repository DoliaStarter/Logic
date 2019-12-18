func_call(Action/_/ResPos, Args,Result):-
    nth1(ResPos,NewArgs,Result,Args),
    Func =.. [Action|NewArgs],
    Func.

func_call(Action/ArgCount,Args,Result):-
     nth1(ArgCount,NewArgs,Result,Args),
     Func =.. [Action|NewArgs],
     Func.


:-op(700,xfx,<#).
:-op(500,xfy,#).

%Result <# FuncName # ArgChain :-
%    parse_args(ArgChain,ArgList),
%    func_call(FuncName,ArgList,Result).

%parse_args(Arg # T, Result):-
%    !,
%    parse_args(T,MidResult),
%    Result = [Arg|MidResult].
%parse_args(Arg,[Arg]).

Result <# Function # ArgsChain:-
    initial_function(Function, IF),
    curry(IF, ArgsChain, Result).

initial_function(function(F,A), function(F,A)) :-
    !.
initial_function(F, function(F, [])).
                    
curry(F, A # T, Result) :-
    !,
    curry_call(F,A,MidResult),
    writeln(MidResult),
    curry(MidResult,T,Result).

curry(F, A, Result):-
    curry_call(F,A,Result).





curry_call(Function,Args,Result):-
    (Function =.. [FuncName,Action/ArgCount/ResPos,FunctionArgs] ->
    writeln('');
    (
        Function =.. [FuncName,Action/ArgCount,FunctionArgs],
        ResPos = ArgCount
    )
    ),
    append(FunctionArgs,[Args],NewArgList),
    (nth1(ResPos,ArgsWithResult,Result,NewArgList)-> 
                   (   
                    NF =.. [Action|ArgsWithResult],
                    NF
                   );
                   (   
                       Result =.. [FuncName,Action/ArgCount/ResPos,NewArgList]
                   )
                   ).

