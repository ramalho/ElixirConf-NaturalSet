defmodule ProtocolDemo do
  @moduledoc """
  Demonstration: implementing `String.Chars` for `MapSet`:

      iex> MapSet.new([4, 2, 1, 3]) |> to_string
      "{1 2 3 4}"

  """

  defimpl String.Chars, for: MapSet do
    def to_string(map_set) do
      s = map_set |> Enum.join(" ")
      "{#{s}}"
    end
  end
end
