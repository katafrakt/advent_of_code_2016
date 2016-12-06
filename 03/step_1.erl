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
process_lines([Head | Tail], Right) ->
  NewRight = process_line(Head, Right),
  process_lines(Tail, NewRight).

process_line(Line, Right) ->
  Parts = string:tokens(Line, " "),
  Ints = lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, Parts),
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