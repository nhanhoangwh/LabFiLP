-module(lab1).
-export([distance/2,insert/2,drop_every/2,rle_decode/1,diagonal/1,intersect/2,is_date/3]).

%1

distance({X1, Y1}, {X2, Y2}) ->
    math:sqrt((X2-X1)*(X2-X1) + (Y2-Y1)*(Y2-Y1)).

%2
insert(List, X) ->
    case List of
        [] -> [X];
        [H|T] ->
            if X < H ->
                [X | List];
            true ->
                [H | insert(T, X)]
            end
    end.

%3
drop_every(List, N) ->
    drop_every(List, N, N).

drop_every([], _, _) ->
    [];
drop_every([_ | T], N, 1) ->
    drop_every(T, N, N);
drop_every([H | T], N, Count) ->
    [H | drop_every(T, N, Count - 1)].

%4
rle_decode(EncodedList) ->
    rle_decode(EncodedList, []).

rle_decode([], Acc) ->
    Acc;
rle_decode([{Char, Count} | T], Acc) ->
    Expanded = expand(Char, Count),
    rle_decode(T, add(Expanded, Acc));
rle_decode([Char | T], Acc) ->
    rle_decode(T, add([Char], Acc)).

expand(_, 0) ->
    [];
expand(Char, Count) ->
    [Char | expand(Char, Count - 1)].

add([], Acc) ->
    Acc;
add([H | T], Acc) ->
    add(T, Acc ++ [H]).

%5

diagonal(Matrix) ->
    diagonal(Matrix, 1, []).
reverse(List) ->
  reverse(List, []).
reverse([Head|Rest], Reversed_List) ->
  reverse(Rest, [Head|Reversed_List]);
reverse([], Reversed_List) ->
  Reversed_List.
diagonal([], _, Acc) ->
    reverse(Acc);
diagonal([Row|Rows], N, Acc) ->
    diagonal(Rows, N+1, [nth(N, Row)|Acc]).
nth(1, [H|_]) -> H;
nth(N, [_|T]) when N > 1 -> nth(N-1, T).

%6
intersect(List1, List2) ->
    intersect(List1, List2, []).

intersect([], _, Acc) ->
    Acc;
intersect(_, [], Acc) ->
    Acc;
intersect([H1 | T1], List2, Acc) ->
    case find(List2, H1) of
        true ->
            intersect(T1, List2, [H1 | Acc]);
        false ->
            intersect(T1, List2, Acc)
    end.

find([], _) ->
    false;
find([H2 | T2], X) ->
    case H2 =:= X of
        true ->
            true;
        false ->
            find(T2, X)
    end.

%7


is_date(DayOfMonth, MonthOfYear, Year) ->
    DayOfWeekIndex = calendar:day_of_the_week({Year, MonthOfYear, DayOfMonth}),
    day_of_week_to_number(DayOfWeekIndex).

day_of_week_to_number(0) -> 7;
day_of_week_to_number(N) when N > 0 -> N;
day_of_week_to_number(_) -> undefined.
