defmodule Aoc08Test do
  use ExUnit.Case

  test "Test File Parsing" do
    assert Aoc08.read_file("day08-test.txt")
       |> Aoc08.split_file()
       |> Aoc08.instructions([]) ==
      [{:ok, "nop", "+", 0},
       {:ok, "acc", "+", 1},
       {:ok, "jmp", "+", 4},
       {:ok, "acc", "+", 3},
       {:ok, "jmp", "-", 3},
       {:ok, "acc", "-", 99},
       {:ok, "acc", "+", 1},
       {:ok, "jmp", "-", 4},
       {:ok, "acc", "+", 6}]
  end
end
