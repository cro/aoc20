defmodule Aoc07Test do
  use ExUnit.Case

  # test "Test File Parsing" do
  #   assert Aoc07.read_file("day07-test.txt")
  #          |> Aoc07.split_file()
  #          |> Aoc07.parse_file()
  # end
  test "Parse one line to components" do
    assert %{"light red" => %{"bright white" => "1", "muted yellow" => "2"}} ==
             Aoc07.parse_line("light red bags contain 1 bright white bag, 2 muted yellow bags.")
  end

  test "Parse a second line to components" do
    assert %{"light red" => %{}} ==
             Aoc07.parse_line("light red bags contain no other bags.")
  end

  test "Parse whole test file." do
    assert %{
             "bright white" => %{"shiny gold" => "1"},
             "dark olive" => %{"dotted black" => "4", "faded blue" => "3"},
             "dark orange" => %{"bright white" => "3", "muted yellow" => "4"},
             "dotted black" => %{},
             "faded blue" => %{},
             "light red" => %{"bright white" => "1", "muted yellow" => "2"},
             "muted yellow" => %{"faded blue" => "9", "shiny gold" => "2"},
             "shiny gold" => %{"dark olive" => "1", "vibrant plum" => "2"},
             "vibrant plum" => %{"dotted black" => "6", "faded blue" => "5"}
           } ==
             "day07-test.txt"
             |> Aoc07.read_file()
             |> Aoc07.split_file()
             |> Aoc07.parse_file(Map.new())
  end
end
