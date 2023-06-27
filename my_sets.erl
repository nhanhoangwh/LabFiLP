-module(my_sets).
-export([run_tests/0]).

run_tests() ->
    Set1 = set:new(),
    Set2 = set:new(),
    Set3 = set:new(),

    Set1_2 = set:add(Set1, 1),
    Set1_3 = set:add(Set1_2, 2),
    Set1_4 = set:add(Set1_3, 3),

    Set2_2 = set:add(Set2, 3),
    Set2_3 = set:add(Set2_2, 4),
    Set2_4 = set:add(Set2_3, 5),

    Set3_2 = set:add(Set3, 1),
    Set3_3 = set:add(Set3_2, 3),
    Set3_4 = set:add(Set3_3, 5),

    %% Test set:add/2
    io:format("set:add/2 test: ~p~n", [set:add(Set1_4, 4) == set:add(Set2_4, 4)]),

    %% Test set:union/2
    io:format("set:union/2 test: ~p~n", [set:union(Set1_4, Set2_4) == set:union(Set2_4, Set1_4)]),

    %% Test set:intersection/2
    io:format("set:intersection/2 test: ~p~n", [set:intersection(Set1_4, Set2_4) == set:intersection(Set2_4, Set1_4)]),

    %% Test set:is_element/2
    io:format("set:is_element/2 test: ~p~n", [set:is_element(4, Set2_4) == true, set:is_element(2, Set2_4) == false]).
