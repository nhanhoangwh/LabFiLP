-module(lab3).

-export([empty/0, insert/2, inorder/1,merge/2]).


%% определяем тип данных для бинарного дерева
% -type tree() :: empty | {node, integer, tree(), tree()}.

%% создаем пустое дерево
empty() -> empty.

%% вставляем элемент в дерево
insert(X, empty) -> {node, X, empty, empty};
insert(X, {node, Y, L, R}) when X < Y -> {node, Y, insert(X, L), R};
insert(X, {node, Y, L, R}) when X > Y -> {node, Y, L, insert(X, R)}.

%% обход в порядке возрастания
inorder(empty) -> [];
inorder({node, X, L, R}) -> inorder(L) ++ [X] ++ inorder(R).

%% функция для слияния двух деревьев
merge(T1, T2) ->
    merge_list(inorder(T1), inorder(T2), lab3:empty()).

%% вспомогательная функция для слияния двух списков в бинарное дерево
merge_list([], [], T) -> T;
merge_list([], [X|Xs], T) -> merge_list([], Xs, lab3:insert(X, T));
merge_list([X|Xs], [], T) -> merge_list(Xs, [], lab3:insert(X, T));
merge_list([X|Xs], [Y|Ys], T) when X =< Y -> merge_list(Xs, [Y|Ys], lab3:insert(X, T));
merge_list([X|Xs], [Y|Ys], T) when X > Y -> merge_list([X|Xs], Ys, lab3:insert(Y, T)).
