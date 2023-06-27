-module(multiset).
-export([new/0, add/2, delete/2, count/2, size/1, items/1, union/2]).

% task 2

new() -> dict:new().

add(Elem, Dict) ->
    case dict:is_key(Elem, Dict) of
        true -> dict:update_counter(Elem, 1, Dict);
        false -> dict:store(Elem, 1, Dict)
    end.

delete(Key, Dict) ->
    case dict:find(Key, Dict) of
        error ->
            Dict;
        {ok, Count} when Count > 1 ->
            dict:store(Key, Count-1, Dict);
        {ok, _Count} ->
            dict:erase(Key, Dict)
    end.

count(Key, Dict) ->
    case dict:find(Key, Dict) of
        error ->
            0;
        {ok, Count} ->
            Count
    end.

size(Dict) -> dict:size(Dict).

items(Dict) -> dict:to_list(Dict).

% task 3

union(Multiset1, Multiset2) ->
    Multiset = dict:merge(fun(_Key, Count1, Count2) ->
        case Count2 of
            undefined -> Count1;
            _ -> Count1 + Count2
        end
    end, Multiset1, Multiset2),
    dict:filter(fun(_Key, Count) -> Count > 0 end, Multiset).

