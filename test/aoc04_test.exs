defmodule Aoc04Test do
  use ExUnit.Case
  # doctest Aoc03

  test "Test File Parsing" do
    ftext = Aoc04.read_file("day04-test.txt")
    splittext = Aoc04.split_file(ftext)
    passport_list = Aoc04.join_file(splittext, "", [])
    assert length(passport_list) == 12
  end

  test "Test key:value Parse" do
    testmap = ["a:b", "c:d", "d:f"] |> Aoc04.make_map()
    assert testmap == %{"a" => "b", "c" => "d", "d" => "f"}
  end

  test "Passport Parse, just keys" do
    parsed_passports =
      Aoc04.read_file("day04-test.txt")
      |> Aoc04.split_file()
      |> Aoc04.join_file("", [])
      |> Aoc04.list_of_maps()

    assert length(parsed_passports) == 12

    valid =
      Enum.count(parsed_passports, fn x ->
        Map.keys(x) == ["byr", "cid", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"] or
          Map.keys(x) == ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]
      end)

    assert valid == 10
  end

  test "Height Test" do
    assert Aoc04.height_test("150cubits") == false
    assert Aoc04.height_test("999cm") == false
    assert Aoc04.height_test("170") == false
    assert Aoc04.height_test("193cm") == true
    assert Aoc04.height_test("60in") == true
    assert Aoc04.height_test("190cm") == true
    assert Aoc04.height_test("190in") == false
    assert Aoc04.height_test("190") == false
  end

  test "Hair Color Test" do
    assert Aoc04.hair_color_test("asdf") == false
    assert Aoc04.hair_color_test("01234567") == false
    assert Aoc04.hair_color_test("#0123456") == false
    assert Aoc04.hair_color_test("#123456") == true
    assert Aoc04.hair_color_test("#123abc") == true
    assert Aoc04.hair_color_test("#123abz") == false
    assert Aoc04.hair_color_test("123abc") == false
    assert Aoc04.hair_color_test("#deadbeef") == false
  end

  test "Passport ID" do
    assert Aoc04.passport_id_test("163069444") == true
    assert Aoc04.passport_id_test("000000001") == true
    assert Aoc04.passport_id_test("0123456789") == false
  end

  test "Validate Passports" do
    ftext = Aoc04.read_file("day04-test.txt")
    splittext = Aoc04.split_file(ftext)
    passport_list = Aoc04.join_file(splittext, "", [])
    parsed_passports = Aoc04.list_of_maps(passport_list)
    assert Enum.count(parsed_passports, fn x -> Aoc04.validate(x) end) == 6
  end
end
