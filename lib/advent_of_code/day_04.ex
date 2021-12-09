defmodule AdventOfCode.Day04 do
  alias __MODULE__.Board

  def part1(args) do
    [raw_numbers_drawn | raw_boards] = String.split(args, "\n\n", trim: true)
    numbers_drawn = parse_numbers(raw_numbers_drawn)
    boards = parse_boards(raw_boards)

    numbers_drawn
    |> Enum.reduce_while(boards, fn num, cur_boards ->
      cur_boards = Enum.map(cur_boards, fn b -> Board.mark(b, num) end)
      winner = Enum.find(cur_boards, fn b -> Board.winner?(b) end)

      if winner != nil do
        {:halt, {winner, num}}
      else
        {:cont, cur_boards}
      end
    end)
    |> Board.score()
  end

  def part2(args) do
    [raw_numbers_drawn | raw_boards] = String.split(args, "\n\n", trim: true)
    numbers_drawn = parse_numbers(raw_numbers_drawn)
    boards = parse_boards(raw_boards)

    numbers_drawn
    |> Enum.reduce_while(boards, fn num, cur_boards ->
      if Enum.count(cur_boards) > 1 do
        cur_boards =
          cur_boards
          |> Enum.map(fn b -> Board.mark(b, num) end)
          |> Enum.reject(&Board.winner?/1)

        {:cont, cur_boards}
      else
        [board] = cur_boards
        board = Board.mark(board, num)

        if Board.winner?(board) do
          {:halt, {board, num}}
        else
          {:cont, [board]}
        end
      end
    end)
    |> Board.score()
  end

  defp parse_numbers(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_boards(input) do
    Enum.map(input, &Board.from_string/1)
  end

  defmodule Board do
    def from_string(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(" ", trim: true)
        |> Enum.map(fn num -> {String.to_integer(num), false} end)
      end)
    end

    def score({board, last_called}) do
      sum =
        board
        |> Enum.flat_map(fn row ->
          row
          |> Enum.filter(fn {_num, mark} -> !mark end)
          |> Enum.map(fn {num, _mark} -> num end)
        end)
        |> Enum.sum()

      sum * last_called
    end

    def mark(board, drawn) do
      board
      |> Enum.map(fn row ->
        Enum.map(row, fn {num, mark} ->
          if drawn == num do
            {num, true}
          else
            {num, mark}
          end
        end)
      end)
    end

    def winner?([
          [{_, true}, {_, true}, {_, true}, {_, true}, {_, true}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}]
        ]),
        do: true

    def winner?([
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, true}, {_, true}, {_, true}, {_, true}, {_, true}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}]
        ]),
        do: true

    def winner?([
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, true}, {_, true}, {_, true}, {_, true}, {_, true}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}]
        ]),
        do: true

    def winner?([
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, true}, {_, true}, {_, true}, {_, true}, {_, true}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}]
        ]),
        do: true

    def winner?([
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, true}, {_, true}, {_, true}, {_, true}, {_, true}]
        ]),
        do: true

    def winner?([
          [{_, true}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, true}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, true}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, true}, {_, _}, {_, _}, {_, _}, {_, _}],
          [{_, true}, {_, _}, {_, _}, {_, _}, {_, _}]
        ]),
        do: true

    def winner?([
          [{_, _}, {_, true}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, true}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, true}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, true}, {_, _}, {_, _}, {_, _}],
          [{_, _}, {_, true}, {_, _}, {_, _}, {_, _}]
        ]),
        do: true

    def winner?([
          [{_, _}, {_, _}, {_, true}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, true}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, true}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, true}, {_, _}, {_, _}],
          [{_, _}, {_, _}, {_, true}, {_, _}, {_, _}]
        ]),
        do: true

    def winner?([
          [{_, _}, {_, _}, {_, _}, {_, true}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, true}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, true}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, true}, {_, _}],
          [{_, _}, {_, _}, {_, _}, {_, true}, {_, _}]
        ]),
        do: true

    def winner?([
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, true}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, true}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, true}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, true}],
          [{_, _}, {_, _}, {_, _}, {_, _}, {_, true}]
        ]),
        do: true

    def winner?(_board), do: false
  end
end
