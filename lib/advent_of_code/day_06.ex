defmodule AdventOfCode.Day06 do
  def part1(args) do
    input =
      args
      |> String.trim()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    calc(input, 80)
  end

  def part2(args) do
    input =
      args
      |> String.trim()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    calc(input, 256)
  end

  defp calc(input, days) do
    initial_state = {0, 0, 0, 0, 0, 0, 0, 0, 0}

    state =
      Enum.reduce(input, initial_state, fn fish, acc ->
        put_elem(acc, fish, elem(acc, fish) + 1)
      end)

    run(state, days)
  end

  defp run(lifetime, 0) do
    Tuple.sum(lifetime)
  end

  defp run(lifetime, days) do
    new = elem(lifetime, 0)

    lifetime =
      for i <- 1..(tuple_size(lifetime) - 1), reduce: lifetime do
        acc -> put_elem(acc, i - 1, elem(acc, i))
      end

    lifetime = put_elem(lifetime, 6, elem(lifetime, 6) + new)
    lifetime = put_elem(lifetime, 8, new)
    run(lifetime, days - 1)
  end
end
