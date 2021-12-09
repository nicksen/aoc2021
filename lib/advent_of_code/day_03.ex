defmodule AdventOfCode.Day03 do
  def part1(args) do
    counts =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))
      |> count()

    gamma =
      counts
      |> Enum.reduce([], fn {_key, {a, b}}, acc ->
        if a > b do
          [0 | acc]
        else
          [1 | acc]
        end
      end)
      |> Enum.reverse()
      |> Integer.undigits(2)

    epsilon =
      counts
      |> Enum.reduce([], fn {_key, {a, b}}, acc ->
        if a < b do
          [0 | acc]
        else
          [1 | acc]
        end
      end)
      |> Enum.reverse()
      |> Integer.undigits(2)

    gamma * epsilon
  end

  def part2(args) do
    lines =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))

    oxygen_generator_rating = calc(lines, 0, &>/2)
    co2_scrubber_rating = calc(lines, 0, &<=/2)

    oxygen_generator_rating * co2_scrubber_rating
  end

  defp count(lines) do
    Enum.reduce(lines, %{}, fn line, acc ->
      line
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {e, i}, acc ->
        acc
        |> Map.put_new(i, {0, 0})
        |> Map.update!(i, fn {a, b} ->
          if e == "0" do
            {a + 1, b}
          else
            {a, b + 1}
          end
        end)
      end)
    end)
  end

  defp calc([line], _, _) do
    line
    |> Enum.map(&String.to_integer/1)
    |> Integer.undigits(2)
  end

  defp calc(lines, i, cmp) do
    counts = count(lines)
    {a, b} = counts[i]
    s = if cmp.(a, b), do: "0", else: "1"
    keep = Enum.filter(lines, fn line -> Enum.at(line, i) == s end)
    calc(keep, i + 1, cmp)
  end
end
