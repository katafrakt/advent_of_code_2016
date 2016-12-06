#!/usr/bin/env escript

main([String]) ->
  Lines = readlines(String),
  process_lines(Lines, 0).

readlines(FileName) ->
  {ok, Device} = file:open(FileName, [read]),
  get_all_lines(Device, []).

get_all_lines(Device, Accum) ->
  case io:get_line(Device, "") of
    eof  -> file:close(Device), Accum;
    Line -> get_all_lines(Device, Accum ++ [Line])
  end.

process_lines([], Right) ->
  io:format("~B~n", [Right]);
process_lines([FirstR | [SecondR | [ ThirdR | Tail]]], Right) ->
  First = string:tokens(FirstR, " "),
  Second = string:tokens(SecondR, " "),
  Third = string:tokens(ThirdR, " "),
  FirstLine = [lists:nth(1, First), lists:nth(1, Second), lists:nth(1, Third)],
  SecondLine = [lists:nth(2, First), lists:nth(2, Second), lists:nth(2, Third)],
  ThirdLine = [lists:nth(3, First), lists:nth(3, Second), lists:nth(3, Third)],
  NewRight1 = process_line(FirstLine, Right),
  NewRight2 = process_line(SecondLine, NewRight1),
  NewRight3 = process_line(ThirdLine, NewRight2),
  process_lines(Tail, NewRight3).

process_line(Line, Right) ->
  %  Parts = string:tokens(Line, " "),
  Ints = lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, Line),
  Correct = check_triad(Ints),
  case Correct of
    true -> Right +1;
    false -> Right
  end.

check_triad(List) ->
  First = lists:nth(1, List),
  Second = lists:nth(2, List),
  Third = lists:nth(3, List),
  (First + Second > Third) and (Second + Third > First) and (Third + First > Second).