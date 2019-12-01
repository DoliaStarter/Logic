In order to execute `func_call.pl` open prolog and type:
 
 ```
 ?- ['global.pl'].
 ?- ['func_call.pl'].
 ?- func_call(append([1],[2,3]),X), X = [1,2,3].
 ```
 
 
