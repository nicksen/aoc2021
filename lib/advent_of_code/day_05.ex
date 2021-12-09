defmodule AdventOfCode.Day05 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.flat_map(&expand(&1, false))
    |> Enum.reduce(%{}, fn point, acc ->
      Map.update(acc, point, 1, fn x -> x + 1 end)
    end)
    |> Enum.filter(fn {_point, c} -> c > 1 end)
    |> Enum.count()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.flat_map(&expand(&1, true))
    |> Enum.reduce(%{}, fn point, acc ->
      Map.update(acc, point, 1, fn x -> x + 1 end)
    end)
    |> Enum.filter(fn {_point, c} -> c > 1 end)
    |> Enum.count()
  end

  defp expand([[x, y1], [x, y2]], _) do
    Enum.map(y1..y2, fn y -> "#{x},#{y}" end)
  end

  defp expand([[x1, y], [x2, y]], _) do
    Enum.map(x1..x2, fn x -> "#{x},#{y}" end)
  end

  defp expand([[x1, y1], [x2, y2]], true) do
    fun =
      if y1 < y2 do
        &+/2
      else
        &-/2
      end

    Enum.with_index(x1..x2, fn x, i -> "#{x},#{fun.(y1, i)}" end)
  end

  defp expand(_, false) do
    []
  end

  defp parse_line(line) do
    line
    |> String.split(" -> ", trim: true)
    |> Enum.map(fn point ->
      point
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
