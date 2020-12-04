defmodule Aoc0201 do
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

  def split_file(ftext) do
    ftext
    |> String.split("\n", trim: true)
  end

  def decode_password(passline) do
    [indices, letter, password] = String.split(passline, " ")
    [startidx, endidx] = Enum.map(String.split(indices, "-"), fn x -> x |> String.to_integer end)
    letter = String.first(letter)
    freqmap = password
       |> String.graphemes
       |> Enum.frequencies
    freq = freqmap[letter]
    _pass = startidx <= freq and freq <= endidx
  end

  def parse_list([], acc) do
    acc
  end

  def parse_list([head | tail], acc) do
    pass = decode_password(head)
    if pass do
      IO.puts(head)
      _res = parse_list(tail, acc+1)
    else
      _res = parse_list(tail, acc)
    end

  end

end
