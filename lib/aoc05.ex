defmodule Aoc05 do
  def read_file(fname) do
    {:ok, ftext} = File.read(fname)
    ftext
  end

  def split_file(ftext) do
    ftext
    |> String.split("\n", trim: true)
  end

  def bp([], top, _bottom, left, _right) do
    {top, left}
  end

  def bp([head | tail], top, bottom, left, right) do
    cond do
      head == "L" -> bp(tail, top, bottom, left, right - round((right - left + 1) / 2))
      head == "R" -> bp(tail, top, bottom, left + round((right - left + 1) / 2), right)
      head == "F" -> bp(tail, top, bottom - round((bottom - top + 1) / 2), left, right)
      head == "B" -> bp(tail, top + round((bottom - top + 1) / 2), bottom, left, right)
    end
  end

  def seat_id({r, c}) do
    r * 8 + c
  end

  def missing_number([], prev) do
    prev
  end

  def missing_number([head | tail], prev) do
    cond do
      prev + 1 == head ->
        missing_number(tail, head)

      true ->
        IO.puts("Skipped from #{prev} to #{head}")
        missing_number(tail, head)
    end
  end

  def main do
    Aoc05.read_file("day05.txt")
    |> Aoc05.split_file()
    |> Enum.map(fn x -> bp(String.graphemes(x), 0, 127, 0, 7) end)
    |> Enum.map(fn x -> seat_id(x) end)
    |> Enum.sort()
    |> missing_number(0)
  end
end
