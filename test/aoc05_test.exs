defmodule Aoc05Test do
  use ExUnit.Case

  test "Test File Parsing" do
    ftext = Aoc05.read_file("day05-test.txt")
    boarding_pass_list = Aoc05.split_file(ftext)
    assert length(boarding_pass_list) == 4
  end

  test "Test Column" do
    assert Aoc05.bp(String.graphemes("FBFBBFFRLR"), 0, 127, 0, 7) == {44, 5}
    assert Aoc05.bp(String.graphemes("BFFFBBFRRR"), 0, 127, 0, 7) == {70, 7}
    assert Aoc05.bp(String.graphemes("FFFBBBFRRR"), 0, 127, 0, 7) == {14, 7}
    assert Aoc05.bp(String.graphemes("BBFFBBFRLL"), 0, 127, 0, 7) == {102, 4}
  end
end
