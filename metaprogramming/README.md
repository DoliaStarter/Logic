`func_call.pl` - implemantation of `func_call/3`. In order to execute `func_call.pl` open prolog and type:
 
 ```
 ?- ['global.pl'].
 ?- ['func_call.pl'].
 ?- func_call(append([1],[1,2,3]),2,X), X = [2,3].
 ```
 
 
