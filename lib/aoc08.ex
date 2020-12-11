defmodule Aoc08 do
  def read_file(fname) do
    {:ok, ftext} = File.read(fname)
    ftext
  end

  def split_file(ftext) do
    ftext
    |> String.split("\n", trim: true)
  end

  def instructions([], instruction_list) do
    Enum.reverse(instruction_list)
  end

  def instructions([head | tail], instruction_list) do
    instructions(tail, [parse_instruction(head) | instruction_list])
  end

  def parse_instruction(line) do
    [instruction, argument] = String.split(line)
    sign = String.slice(argument, 0..0)
    argument = String.to_integer(String.slice(argument, 1..-1))
    {:ok, instruction, sign, argument}
  end


  def exec(instruction, pc, acc) do
    {:ok, instruction, sign, arg} = instruction
    arg = if sign == "-" do
      -arg
    else
      arg
    end
    cond do
      instruction == "nop" -> {pc + 1, acc}
      instruction == "jmp" -> {pc + arg, acc}
      instruction == "acc" -> {pc + 1, acc + arg}
    end
  end

  def flip_instruction(program, location) do
    {:ok, instruction, sign, arg} = Enum.at(program, location)
    program |> List.replace_at(location,
      cond do
        instruction == "jmp" -> {:ok, "nop", sign, arg}
        instruction == "nop" -> {:ok, "jmp", sign, arg}
        true -> {:ok, instruction, sign, arg}
      end)
  end

  def test_run(program, location_to_flip) do

    IO.puts("Flipped instruction at #{location_to_flip}")
    {result, acc, _pc} = run(flip_instruction(program, location_to_flip), [], {0, 0})
    cond do
      location_to_flip > length(program) -> {"failed", acc}
      result == "terminate" -> {"terminate", acc}
      result == "loop" -> test_run(program, location_to_flip + 1)
    end
  end

  def run(program, executed, {pc, acc}) do
    cond do
      pc in executed -> {"loop", acc, pc}
      Enum.at(program, pc) == nil ->
          {"terminate", acc, pc}
      pc > length(program) ->
          {"terminate", pc}

      true -> run(program, [pc | executed], exec(Enum.at(program, pc), pc, acc))
    end
  end

  def main do
    "day08.txt"
    |> read_file
    |> split_file
    |> instructions([])
    |> test_run(0)
    |> IO.inspect()
  end
end
