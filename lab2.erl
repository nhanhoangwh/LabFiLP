-module(lab2).
-export([list_lengths/1,all/2,min_value/2,group_by/2,for/4,sortBy/2]).

% 1
list_lengths(List) ->
    [length(X) || X <- List, is_list(X)].

% 2
all(Pred, List) ->
    all_helper(Pred, List).

all_helper(_, []) ->
    true;
all_helper(Pred, [H | T]) ->
    case Pred(H) of
        true ->
            all_helper(Pred, T);
        false ->
            false
    end.
% 3
min_value(F, N) ->
    min_value(F, N, F(1)).

min_value(F, N, Min) when N > 1 ->
    min_value(F, N - 1, min(Min, F(N)));
min_value(_, _, Min) ->
    Min.
% 4
group_by(Fun, List) ->
    group_by(Fun, List, []).

group_by(_, [], Acc) ->
    lists:reverse(Acc);
    
group_by(Fun, [H | T], Acc) ->
    case Acc of
        [] ->
            group_by(Fun, T, [[H]]);
        [Group | Groups] ->
            case Fun(lists:last(Group), H) of
                true ->
                    group_by(Fun, T, [lists:append(Group, [H]) | Groups]);
                false ->
                    group_by(Fun, T, [[H] | Acc])
            end
    end.

% 5
for(I, Cond, Step, Body) ->
    case Cond(I) of
        false -> 
            ok;
        true ->
            Body(I),
            for(Step(I), Cond, Step, Body)
    end.
% 6
-spec sortBy(fun((A :: any(), B :: any()) -> less | equal | greater), List :: list()) -> list().
sortBy(_Comparator, []) ->
    [];
sortBy(_Comparator, [X]) ->
    [X];
sortBy(Comparator, List) ->
    {Left, Right} = split(List, length(List) div 2),
    merge(sortBy(Comparator, Left), sortBy(Comparator, Right), Comparator).

split(List, Mid) ->
    split(List, Mid, []).
split(List, 0, Acc) ->
    {lists:reverse(Acc), List};
split([X|Xs], N, Acc) ->
    split(Xs, N-1, [X|Acc]).

merge([], Right, _Comparator) ->
    Right;
merge(Left, [], _Comparator) ->
    Left;
merge([Left|LeftRest], [Right|RightRest], Comparator) ->
    case Comparator(Left, Right) of
        less ->
            [Left|merge(LeftRest, [Right|RightRest], Comparator)];
        equal ->
            [Left, Right|merge(LeftRest, RightRest, Comparator)];
        greater ->
            [Right|merge([Left|LeftRest], RightRest, Comparator)]
    end.
