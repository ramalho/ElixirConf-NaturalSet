defmodule NaturalSet do

  use Bitwise, only_operators: true

  defstruct bits: 0

  def new, do: %NaturalSet{}

  def new(enumerable) do
    Enum.reduce(enumerable, %NaturalSet{}, &NaturalSet.put(&2, &1))
  end

  def new(enumerable, transform) when is_function(transform, 1) do
    enumerable
    |> Stream.map(transform)
    |> new
  end

  def put(%NaturalSet{bits: bits}, element) when is_integer(element) and element >= 0 do
    %NaturalSet{bits: 1 <<< element ||| bits}
  end

  def member?(%NaturalSet{bits: bits}, element) when is_integer(element) and element >= 0 do
    (bits >>> element &&& 1) == 1
  end

  def delete(natural_set, element) when is_integer(element) and element >= 0 do
    if member?(natural_set, element) do
      new_bits = (1 <<< element) ^^^ natural_set.bits
    %NaturalSet{bits: new_bits}
    else
      natural_set  # return unchanged
    end
  end

  def equal?(%NaturalSet{bits: bits1}, %NaturalSet{bits: bits2}) do
    bits1 == bits2
  end

  def intersection(%NaturalSet{bits: bits1}, %NaturalSet{bits: bits2}) do
    %NaturalSet{bits: bits1 &&& bits2}
  end

  def union(%NaturalSet{bits: bits1}, %NaturalSet{bits: bits2}) do
    %NaturalSet{bits: bits1 ||| bits2}
  end

  def difference(%NaturalSet{bits: bits1}, %NaturalSet{bits: bits2}) do
    %NaturalSet{bits: bits1 &&& bits2 ^^^ bits1}
  end

  def subset?(natural_set1, natural_set2) do
    difference(natural_set1, natural_set2).bits == 0
  end

  def disjoint?(natural_set1, natural_set2) do
    intersection(natural_set1, natural_set2).bits == 0
  end

  def length(%NaturalSet{bits: bits}) do
    count_ones(bits, 0)
  end

  defp count_ones(0, count), do: count

  defp count_ones(bits, count) do
    count = count + (bits &&& 1)
    count_ones(bits >>> 1, count)
  end

  def stream(%NaturalSet{bits: bits}) do
    Stream.unfold({bits, 0}, &next_one/1)
  end

  defp next_one({0, _index}), do: nil

  defp next_one({bits, index}) when (bits &&& 1) == 1 do
    # LSB is one: return {next_element, new_accumulator_tuple}
    {index, {bits >>> 1, index + 1}}
  end

  defp next_one({bits, index}) do
    # LSB is 0: shift bits; increment index; try again
    next_one({bits >>> 1, index + 1})
  end

  def to_list(natural_set) do
    natural_set |> stream |> Enum.to_list
  end

  defimpl Enumerable do
    def count(natural_set) do
      {:ok, NaturalSet.length(natural_set)}
    end

    def member?(natural_set, val) do
      {:ok, NaturalSet.member?(natural_set, val)}
    end

    def slice(_set) do
      {:error, __MODULE__}
    end

    def reduce(natural_set, acc, fun) do
      Enumerable.List.reduce(NaturalSet.to_list(natural_set), acc, fun)
    end
  end

  defimpl Collectable do
    def into(original) do
      collector_fun = fn
        set, {:cont, elem} -> NaturalSet.put(set, elem)
        set, :done -> set
        _set, :halt -> :ok
      end

      {original, collector_fun}
    end
  end

  defimpl Inspect do
    import Inspect.Algebra

    def inspect(natural_set, opts) do
      concat(["#NaturalSet<", Inspect.List.inspect(NaturalSet.to_list(natural_set), opts), ">"])
    end
  end
end
