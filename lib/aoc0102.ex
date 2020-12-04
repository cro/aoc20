defmodule Aoc0102 do
  @moduledoc """
  Documentation for `Aoc20`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Aoc20.hello()
      :world

  """
  def read_file(fname) do
    {:ok, ftext} = File.read(fname)
    ftext
  end

  def parse_file(ftext) do
    ftext
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> x |> String.to_integer end)
  end

  def compare_list([], acc1, acc2) do
    [acc1, acc2]
  end

  def compare_list([head | tail], acc1, acc2) do
    if Enum.sum([acc1, acc2, head]) == 2020 do
      IO.puts(acc1)
      IO.puts(acc2)
      IO.puts(head)
      IO.puts(acc1 * acc2 * head)
      acc1 * acc2 * head
    else
      compare_list(tail, acc1, acc2)
    end

  end

  def compare_list1([], acc1) do
    IO.puts("compare_list1 done")
    acc1
  end

  def compare_list1([head | tail], acc1) do
    compare_list(tail, head, acc1)
    compare_list1(tail, acc1)
  end

  def break_list([]) do
    IO.puts("break_list done")
  end

  def break_list(list_of_nums) do
    [acc1 | rest1] = list_of_nums

    compare_list1(rest1, acc1)
    break_list(rest1)

  end
end
