defmodule AdventOfCode.Day01 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({-1, 0}, fn curr, {cnt, prev} ->
      if curr > prev do
        {cnt + 1, curr}
      else
        {cnt, curr}
      end
    end)
    |> elem(0)
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.reduce({-1, 0}, fn curr, {cnt, prev} ->
      if curr > prev do
        {cnt + 1, curr}
      else
        {cnt, curr}
      end
    end)
    |> elem(0)
  end
end
