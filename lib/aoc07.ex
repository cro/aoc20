defmodule Aoc07 do
  def read_file(fname) do
    {:ok, ftext} = File.read(fname)
    ftext
  end

  def split_file(ftext) do
    ftext
    |> String.split("\n", trim: true)
  end

  def parse_file([], bag_map) do
    bag_map
  end

  def parse_file([head | tail], bag_map) do
    parse_file(tail, Map.merge(parse_line(head), bag_map))
  end

  def parse_line(line) do
    [container, contents] = line |> String.split(" contain ")
    raw_bag_contents = Regex.scan(~r/(\d+|no other) (\w+ \w+)* bags*(, |\.*)/, contents)
    bag_contents = Enum.map(raw_bag_contents, fn x -> Enum.slice(x, 1..-2) end)

    container = String.trim(container, " bags")
    Map.put(%{}, container, Map.new(bag_contents, fn x -> {List.last(x), List.first(x)} end))
  end

  def bags_inside(bag, bag_map, total) do
    in_this_bag = bag_map[bag]
    IO.puts("total so far #{total}, this bag is #{bag}")
    IO.inspect(in_this_bag)
    cond do
      in_this_bag == %{} -> 0
      true ->

        Enum.map(Map.keys(in_this_bag), fn x ->
        String.to_integer(in_this_bag[x]) + bags_inside(x, bag_map, 1) * String.to_integer(in_this_bag[x]) end)
        |> Enum.sum
    end

  end
  def find_my_bag(check_in_here, my_bag) do
    cond do
      my_bag in check_in_here ->
        1
      true ->
        0
    end
  end

  def find_contained_bags(_bag_map, [], contained) do
    contained
  end

  def find_contained_bags(bag_map, check_in_here, contained) do
    Enum.flat_map(check_in_here, fn x -> [x] ++ find_contained_bags(bag_map, Map.keys(bag_map[x]), contained) end)
  end

  def main do
    bag_map = "day07.txt"
    |> Aoc07.read_file()
    |> Aoc07.split_file()
    |> parse_file(Map.new())

    Enum.map(Map.keys(bag_map), fn x -> find_contained_bags(bag_map, Map.keys(bag_map[x]), []) end)
    |> Enum.map(fn x -> find_my_bag(x, "shiny gold") end)
    |> Enum.sum
    |> IO.puts

    bags_inside("shiny gold", bag_map, 1)
    |> IO.puts
  end
end
