defmodule AdventOfCode.Day02 do
  def part1(args) do
    {x, y} =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)
      |> Enum.reduce({0, 0}, fn {dx, dy}, {x, y} -> {x + dx, y + dy} end)

    x * y
  end

  def part2(args) do
    {x, y, _} =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)
      |> Enum.reduce({0, 0, 0}, fn {dx, dy}, {x, y, a} ->
        ady = dx * a
        {x + dx, y + ady, a + dy}
      end)

    x * y
  end

  defp parse_line(line) do
    line
    |> String.split(" ", parts: 2)
    |> case do
      ["forward", distance] -> {String.to_integer(distance), 0}
      ["down", distance] -> {0, String.to_integer(distance)}
      ["up", distance] -> {0, String.to_integer(distance) * -1}
    end
  end
end
