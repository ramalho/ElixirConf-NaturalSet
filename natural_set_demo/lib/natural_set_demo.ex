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
      iex> NaturalSet.new([1]).bits |> inspect(base: :binary)
      "0b10"
      iex> NaturalSet.new([0, 1]).bits |> inspect(base: :binary)
      "0b11"
      iex> NaturalSet.new(1..5).bits |> inspect(base: :binary)
      "0b111110"
      iex> NaturalSet.new([1, 3, 5]).bits |> inspect(base: :binary)
      "0b101010"
      iex> NaturalSet.new([0, 2, 4]).bits |> inspect(base: :binary)
      "0b10101"
      iex> NaturalSet.new([100, 1, 0, 50]).bits |> inspect(base: :binary)
      "0b10000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000011"
      iex> NaturalSet.new([100, 1, 0, 50]).bits
      1267650600228230527396610048003
      iex> NaturalSet.new([100, 1, 0, 50])
      #NaturalSet<[0, 1, 50, 100]>

  ## How to put an element in a `NaturalSet`

      iex(1)> use Bitwise
      Bitwise
      iex(2)> ns = NaturalSet.new([0, 4, 5])
      #NaturalSet<[0, 4, 5]>
      iex(3)> ns.bits
      49
      iex(4)> ns.bits |> inspect(base: :binary)
      "0b110001"
      iex(5)> element = 2
      2
      iex(6)> 1 <<< element
      4
      iex(7)> (1 <<< element) |> inspect(base: :binary)
      "0b100"
      iex(8)> 0b100 ||| ns.bits
      53
      iex(9)> (0b100 ||| ns.bits) |> inspect(base: :binary)
      "0b110101"
      iex(10)> %NaturalSet{bits: 0b110101}
      #NaturalSet<[0, 2, 4, 5]>

  ## Protocol `String.Chars`

      iex> 65 |> to_string
      "65"
      iex> [65, 66, 67] |> to_string
      "ABC"
      iex> :café |> to_string
      "café"
      iex> MapSet.new |> to_string
      ** (Protocol.UndefinedError) protocol String.Chars not implemented for #MapSet<[]> of type MapSet (a struct). This protocol is implemented for the following type(s): NaturalSet, Float, DateTime, Time, List, Version.Requirement, Atom, Integer, Version, Date, BitString, NaiveDateTime, URI

  ## After implementing protocol `String.Chars` for `NaturalSet`:

      iex> NaturalSet.new([2, 3, 5, 6]) |> to_string
      "0b1101100"
  """

  defimpl String.Chars, for: NaturalSet do
    def to_string(natural_set), do: natural_set.bits |> inspect(base: :binary)
  end
end
