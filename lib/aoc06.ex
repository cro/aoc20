defmodule Aoc06 do
  def read_file(fname) do
    {:ok, ftext} = File.read(fname)
    ftext
  end

  def split_file(ftext) do
    ftext
    |> String.split("\n", trim: false)
  end

  def join_file([], thisline, ftext) do
    cond do
      thisline == "" -> ftext
      true -> ftext ++ [thisline]
    end
  end

  def join_file([head | tail], thisline, ftext) do
    # IO.puts("====")
    # IO.puts("head " <> head)
    # IO.puts("thisline " <> thisline)
    # IO.puts("ftext: ")
    # IO.puts(ftext)
    cond do
      String.trim(head) == "" -> join_file(tail, "", ftext ++ [String.trim(thisline)])
      true -> join_file(tail, thisline <> " " <> head, ftext)
    end
  end

  def line_to_set(line) do
    line |> String.trim() |> String.graphemes() |> MapSet.new()
  end

  def group_to_set(answer_list) do
    answer_list
    |> Enum.map(&line_to_set/1)
    |> Enum.reduce(fn x, acc -> MapSet.intersection(x, acc) end)
  end

  def group_answers_as_list(joined_answers_from_file) do
    joined_answers_from_file
    |> Enum.map(fn x -> x |> String.split(" ") end)
  end

  def join_file_to_set([], thisline, ftext) do
    cond do
      thisline == "" -> ftext
      true -> ftext ++ [thisline]
    end
  end

  def join_file_to_set([head | tail], thisline, list_of_answers) do
    cond do
      String.trim(head) == "" ->
        join_file_to_set(tail, "", group_to_set(list_of_answers))

      true ->
        join_file_to_set(tail, thisline <> head, list_of_answers)
    end
  end

  def everyone_answered() do
  end

  def main do
    anyone =
      Aoc06.read_file("day06.txt")
      |> Aoc06.split_file()
      |> Aoc06.join_file("", [])
      |> Enum.map(fn x ->
        String.graphemes(x) |> MapSet.new()
      end)
      |> Enum.map(fn x -> MapSet.size(x) end)
      |> Enum.sum()

    IO.puts("Number of questions to which anyone answered yes: #{anyone}")

    everyone =
      Aoc06.read_file("day06.txt")
      |> Aoc06.split_file()
      |> Aoc06.join_file("", [])
      |> Aoc06.group_answers_as_list()
      |> Enum.map(fn x -> x |> Aoc06.group_to_set() end)
      |> Enum.map(&MapSet.size/1)
      |> Enum.sum()

    IO.puts("Number of questions to which EVERYONE answered yes: #{everyone}")
  end
end
