defmodule Aoc0101 do
  @moduledoc """
  Documentation for `Aoc20`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Aoc20.hello()
      :world

  """
  def hello do
    :world
  end

  def read_file(fname) do
    {:ok, ftext} = File.read(fname)
    ftext
  end

  def parse_file(ftext) do
    ftext
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> x |> String.to_integer end)
  end

  def compare_list([], acc) do
    acc
  end

  def compare_list([head | tail], acc) do
    if acc + head == 2020 do
             IO.puts(acc)
             IO.puts(head)
             IO.puts(acc * head)
        acc * head
    else
      compare_list(tail, acc)
    end

  end

  def break_list([]) do
    IO.puts("none")
  end

  def break_list(list_of_nums) do
    [st_num | rest] = list_of_nums

    compare_list(rest, st_num)
    break_list(rest)

  end
end
