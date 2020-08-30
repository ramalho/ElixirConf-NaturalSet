defmodule NaturalSetDemo do
  @moduledoc """
  Tests to demonstrate `NaturalSet`

  ## Bit vector demonstration

  iex> NaturalSet.new()
  #NaturalSet<[]>
  iex> NaturalSet.new().bits
  0
  iex> NaturalSet.new([0]).bits
  1
  iex> NaturalSet.new([1]).bits
  2
  iex> NaturalSet.new([1]) |> to_string
  "10"
  iex> NaturalSet.new([0, 1]) |> to_string
  "11"
  iex> NaturalSet.new(1..5) |> to_string
  "111110"
  iex> NaturalSet.new([1, 3, 5]) |> to_string
  "101010"
  iex> NaturalSet.new([0, 2, 4]) |> to_string
  "10101"
  iex> NaturalSet.new([100, 1, 0, 50]) |> to_string
  "10000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000011"
  iex> NaturalSet.new([100, 1, 0, 50]).bits
  1267650600228230527396610048003
  iex> NaturalSet.new([100, 1, 0, 50])
  #NaturalSet<[0, 1, 50, 100]>

  ## Protocol String.Chars

  iex> MapSet.new |> to_string
  ** (Protocol.UndefinedError) protocol String.Chars not implemented for #MapSet<[]> of type MapSet (a struct). This protocol is implemented for the following type(s): NaturalSet, Float, DateTime, Time, List, Version.Requirement, Atom, Integer, Version, Date, BitString, NaiveDateTime, URI
  iex> NaturalSet.new([2, 3, 5, 6]) |> to_string
  "1101100"

  """
  defimpl String.Chars, for: NaturalSet do
    def to_string(natural_set), do: natural_set.bits |> Integer.to_string(2)
  end

end
