defmodule Fibonacci do
  @doc ~S"""
  Yields the Fibonacci sequence, limited only by available memory

  ## Example

      iex> Fibonacci.stream() |> Enum.take(10)
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  """
  def stream() do
    Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
  end

  @doc ~S"""
  Yields `count` numbers from the Fibonacci sequence.

  ## Example

      iex> Fibonacci.stream_count(10) |> Enum.to_list
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  """

  def stream_count(count) do
    Stream.unfold({count, 0, 1}, fn
      {0, _, _} -> nil
      {count, a, b} -> {a, {count - 1, b, a + b}}
    end)
  end

  @doc ~S"""
  Yields numbers from the Fibonacci sequence up to `max`.

  ## Example

      iex> Fibonacci.stream_max(100) |> Enum.to_list
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
  """
  def stream_max(max) do
    Stream.unfold({0, 1}, fn
      {a, _} when a > max -> nil
      {a, b} -> {a, {b, a + b}}
    end)
  end
end
