defmodule Aoc04 do

  def read_file(fname) do
    {:ok, ftext} = File.read(fname)
    ftext
  end

  def split_file(ftext) do
    ftext
    |> String.split("\n", trim: false)
  end

  def join_file([], thisline, ftext) do
    cond do
      thisline == "" -> ftext
      true -> ftext ++ [thisline]
    end
  end

  def join_file([head | tail], thisline, ftext) do

    # IO.puts("====")
    # IO.puts("head " <> head)
    # IO.puts("thisline " <> thisline)
    # IO.puts("ftext: ")
    # IO.puts(ftext)
    cond do
      String.trim(head) == "" -> join_file(tail, "", ftext ++ [thisline])
      true -> join_file(tail, thisline <> " " <> head, ftext)
    end
  end

  def make_map(passport_entry) do
    Enum.reduce(passport_entry, %{}, fn(passport, result) ->
      String.split(passport, ":")
      |> (fn(x) -> Map.put(result, hd(x), List.last(x)) end).()
    end)
  end

  def list_of_maps(passports) do
    passports
    |> Enum.map(fn passport -> passport |> String.split(" ", trim: true) |> make_map end)
  end

  def height_test(hgt) do
    _test_ok = (String.ends_with?(hgt, "cm") or String.ends_with?(hgt, "in"))
    and (
          val = hgt |> String.slice(0..-3) |> String.to_integer
          ((String.ends_with?(hgt, "cm") and val >= 150 and val <= 193))
           or ((String.ends_with?(hgt, "in") and val >= 59 and val <= 76))
           )

  end

  def hair_color_test(hcl) do
      String.length(hcl) == 7
      and Regex.match?(~r/#([0-9a-f])+$/, hcl)
  end

  def eye_color_test(ecl) do
    ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  end

  def passport_id_test(pid) do
    _ret = try do
      _pid = pid |> String.to_integer
      String.length(pid) == 9
    rescue
      _e -> false
    end
  end

  def country_id_test(_cid) do
   true
  end

  def validate(passport) do
    (Map.keys(passport) == ["byr","cid","ecl","eyr","hcl","hgt","iyr","pid"] or
      Map.keys(passport) == ["byr","ecl","eyr","hcl","hgt","iyr","pid"])
    and (passport["byr"] |> String.to_integer >= 1920 and passport["byr"] |> String.to_integer <= 2002)
    and (passport["iyr"] |> String.to_integer >= 2010 and passport["iyr"] |> String.to_integer <= 2020)
    and (passport["eyr"] |> String.to_integer >= 2020 and passport["iyr"] |> String.to_integer <= 2030)
    and (height_test(passport["hgt"])) and (hair_color_test(passport["hcl"])) and (eye_color_test(passport["ecl"]))
    and (passport_id_test(passport["pid"])) and (country_id_test(passport["cid"]))
  end

  def main do
    parsed_passports = Aoc04.read_file("day04.txt")
    |> Aoc04.split_file
    |> Aoc04.join_file("",[])
    |> Aoc04.list_of_maps

    valid = Enum.filter(parsed_passports, fn x -> validate(x) end)
    Enum.map(valid, fn x -> IO.inspect(x) end)
    _x = IO.puts("I see #{length(valid)} valid passports out of #{length(parsed_passports)}.")

  end

end
