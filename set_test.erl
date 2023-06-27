-module(set_test).
-compile(export_all).

set_test() ->
    Set1 = set:create_set(),
    Set2 = set:create_set(),
    Set3 = set:add_to_set(1, Set1),
    Set4 = set:add_to_set(2, Set3),
    Set5 = set:add_to_set(3, Set4),
    Set6 = set:add_to_set(2, Set5),
    Set7 = set:remove_from_set(3, Set6),
    Set8 = set:remove_from_set(4, Set7),
    true = set:is_member(2, Set7),
    false = set:is_member(4, Set7),
    Set9 = set:create_set(),
    Set10 = set:add_to_set(1, Set9),
    Set11 = set:add_to_set(2, Set10),
    Set12 = set:add_to_set(3, Set11),
    Set13 = set:create_set(),
    Set14 = set:add_to_set(2, Set13),
    Set15 = set:add_to_set(3, Set14),
    Set16 = set:add_to_set(4, Set15),
    Set17 = set:set_intersection(Set12, Set16),
    Set18 = set:set_union(Set12, Set16),
    Set19 = set:set_difference(Set12, Set16),
    true = set:sets_are_equal(Set5, Set6),
    true = set:sets_are_equal(Set18, [1,2,3,4]),
    true = set:sets_are_equal(Set19, [1]).
