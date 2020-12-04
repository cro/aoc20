defmodule Aoc03Test do
  use ExUnit.Case
  #doctest Aoc03

  test "Test Coordinates" do

    {:ok, rows} = Aoc03.read_file("day03-test.txt") |> Aoc03.split_file |> Aoc03.create_table
    assert rows == 11
    assert Aoc03.get_wraparound_coordinate(0, 0) == "."
    assert Aoc03.get_wraparound_coordinate(1, 4) == "#"
    assert Aoc03.get_wraparound_coordinate(90, 0) == "@"
    assert Aoc03.get_wraparound_coordinate(1, 15) == "#"
    assert Aoc03.get_wraparound_coordinate(1, 22) == "#"
    assert Aoc03.get_wraparound_coordinate(1, 9) == "."
    assert Aoc03.get_wraparound_coordinate(1, 10) == "."
    assert Aoc03.get_wraparound_coordinate(1, 11) == "#"

  end

  test "Sample Schuss" do
    {:ok, _rows} = Aoc03.read_file("day03-test.txt") |> Aoc03.split_file |> Aoc03.create_table
    assert Aoc03.schuss(0, 0, 1, 3, 0) == 7
    assert Aoc03.schuss(0, 0, 1, 1, 0) == 2
    assert Aoc03.schuss(0, 0, 1, 5, 0) == 3
    assert Aoc03.schuss(0, 0, 1, 7, 0) == 4
    assert Aoc03.schuss(0, 0, 2, 1, 0) == 2
  end
end
