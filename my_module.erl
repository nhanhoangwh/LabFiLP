-module(my_module).
-export([for/4]).

for(I, Cond, Step, Body) ->
    case Cond(I) of
        false -> 
            ok;
        true ->
            Body(I),
            for(Step(I), Cond, Step, Body)
    end.
