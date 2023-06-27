-module(set).
-export([create_set/0, add_to_set/2, remove_from_set/2, is_member/2, set_intersection/2, set_union/2, set_difference/2, sets_are_equal/2]).

create_set() ->
    [].

add_to_set(Element, Set) ->
    case lists:member(Element, Set) of
        true ->
            Set;
        false ->
            [Element | Set]
    end.

remove_from_set(Element, Set) ->
    lists:delete(Element, Set).

is_member(Element, Set) ->
    lists:member(Element, Set).

set_intersection(Set1, Set2) ->
    lists:usort(lists:append([X || X <- Set1, is_member(X, Set2)], [Y || Y <- Set2, is_member(Y, Set1)])).

set_union(Set1, Set2) ->
    lists:usort(lists:append(Set1, Set2)).

set_difference(Set1, Set2) ->
    lists:usort([X || X <- Set1, not is_member(X, Set2)]).

sets_are_equal(Set1, Set2) ->
    lists:sort(Set1) == lists:sort(Set2).
