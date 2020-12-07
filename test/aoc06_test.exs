defmodule Aoc06Test do
  use ExUnit.Case

  test "Test File Parsing" do
    assert Aoc06.read_file("day06-test.txt")
           |> Aoc06.split_file()
           |> Aoc06.join_file("", []) ==
             ["abc", "a b c", "ab ac", "a a a a", "b"]
  end

  test "Group Answers as List" do
    res = ["abc", "a b c", "ab ac", "a a a a", "b"] |> Aoc06.group_answers_as_list()
    assert res == [["abc"], ["a", "b", "c"], ["ab", "ac"], ["a", "a", "a", "a"], ["b"]]
  end

  test "Group Answer to Intersected Set" do
    assert ["a", "ba", "ac"] |> Aoc06.group_to_set() == MapSet.new(["a"])
  end

  test "Answer List as Intersected Set" do
    assert ["abc", "a b c", "ab ac", "a a a a", "azxx"]
           |> Aoc06.group_answers_as_list()
           |> Enum.map(fn x -> x |> Aoc06.group_to_set() end) == [
             MapSet.new(["a", "b", "c"]),
             MapSet.new([]),
             MapSet.new(["a"]),
             MapSet.new(["a"]),
             MapSet.new(["a", "x", "z"])
           ]
  end

  test "Sum of All Answered Yes" do
    assert ["abc", "a b c", "ab ac", "a a a a", "azxx"]
           |> Aoc06.group_answers_as_list()
           |> Enum.map(fn x -> x |> Aoc06.group_to_set() end)
           |> Enum.map(&MapSet.size/1)
           |> Enum.sum() == 8
  end
end
