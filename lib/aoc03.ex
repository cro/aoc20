defmodule Aoc03 do
  @moduledoc """
  Documentation for `Aoc20`.
  """

  @doc """
  ETS lookups

  ## Examples

  """

  def read_file(fname) do
    {:ok, ftext} = File.read(fname)
    ftext
  end

  def split_file(ftext) do
    ftext
    |> String.split("\n", trim: true)
  end

  def split_row(linetext) do
    linetext |> String.graphemes()
  end

  def add_row([], rownum) do
    {:ok, rownum}
  end

  def add_row([head | tail], rownum) do
    :ets.insert(:landscape, {rownum, head |> split_row})
    add_row(tail, rownum + 1)
  end

  def create_table(puzzle) do
    :ets.new(:landscape, [:set, :public, :named_table])
    add_row(puzzle, 0)
  end

  def get_wraparound_coordinate(rownum, colnum) do
    cell =
      try do
        [{_rowkey, row}] = :ets.lookup(:landscape, rownum)

        cond do
          colnum >= length(row) -> Enum.at(row, rem(colnum, length(row)))
          true -> Enum.at(row, colnum)
        end
      rescue
        _e in MatchError -> "@"
      end

    cell
  end

  def schuss(row, col, rowdelta, coldelta, acc) do
    tree = get_wraparound_coordinate(row, col)

    cond do
      tree == "#" ->
        schuss(row + rowdelta, col + coldelta, rowdelta, coldelta, acc + 1)

      tree == "." ->
        schuss(row + rowdelta, col + coldelta, rowdelta, coldelta, acc)

      tree == "@" ->
        acc
    end
  end

  def main do
    {:ok, _rows} =
      read_file("day03.txt")
      |> split_file
      |> create_table

    s1 = schuss(0, 0, 1, 1, 0)
    s2 = schuss(0, 0, 1, 3, 0)
    s3 = schuss(0, 0, 1, 5, 0)
    s4 = schuss(0, 0, 1, 7, 0)
    s5 = schuss(0, 0, 2, 1, 0)

    s1 * s2 * s3 * s4 * s5
  end
end
