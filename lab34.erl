-module(lab34).
-export([new/0, add/2, delete/2, count/2, size/1, items/1, union/2]).

% task 2

new() -> [].

add(Elem, List) ->
    case lists:keysearch(Elem, 1, List) of
        {value, {Elem, Count}} -> lists:keyreplace(Elem, 1, List, {Elem, Count+1});
        false -> [{Elem, 1}|List]
    end.

delete(Elem, List) ->
    case lists:keysearch(Elem, 1, List) of
        {value, {Elem, Count}} when Count > 1 -> lists:keyreplace(Elem, 1, List, {Elem, Count-1});
        {value, {Elem, _Count}} -> lists:keydelete(Elem, 1, List);
        false -> List
    end.

count(Elem, List) ->
    case lists:keysearch(Elem, 1, List) of
        {value, {Elem, Count}} -> Count;
        false -> 0
    end.

size(List) -> length(List).

items(List) -> List.

% task 3

union(List1, List2) ->
    lists:foldl(fun({Elem, Count}, Acc) ->
        case lists:keysearch(Elem, 1, Acc) of
            {value, {Elem, Count2}} -> lists:keyreplace(Elem, 1, Acc, {Elem, Count+Count2});
            false -> [{Elem, Count}|Acc]
        end
    end, List2, List1).
