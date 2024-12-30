defmodule AdventOfCode.Day01 do
  def part1(args) do

    {l, r} = left_and_right(args)

    # compare elements of the lists
    Enum.with_index(l)
    |> Enum.map(fn {val, index} ->
      abs(val - Enum.at(r, index))
    end)
    |> Enum.sum()
  end

  def part2(args) do
    {l, r} = left_and_right(args)

    # make the right list a map where the element in the list is the key and the value is the number of times it appears
    r_map = Enum.reduce(r, %{}, fn val, acc ->
      Map.update(acc, val, 1, &(&1 + 1))
    end)

    Enum.map(l, fn val ->
      case Map.get(r_map, val) do
      nil -> 0
      count -> val * count
      end
    end) |> Enum.sum()
  end

  defp left_and_right(args) do
        # split input by newlines
    {left, right} = args
    |> String.split("\n")

    # split each newline by space
    |> Enum.map(&String.split(&1, " "))

    # the first and last values are strings, convert them to integers, drop the middle empty string
    |> Enum.map(fn list ->
      list
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.to_integer/1)
      |> case do
      [] -> nil
      tuple_list -> List.to_tuple(tuple_list)
      end
    end)
    |> Enum.reject(&is_nil/1)

    # for each element in the list, put the first tuple member in one list and the second in another
    |> Enum.reduce({[], []}, fn {a, b}, {list_a, list_b} ->
      {list_a ++ [a], list_b ++ [b]}
    end)

    # sort left and right lists
    l = Enum.sort(left)
    r = Enum.sort(right)
    {l, r}
  end
end
