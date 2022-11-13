defmodule HandlebarsRs do
  @moduledoc """
  Documentation for `HandlebarsRs`.
  """

  defguardp is_keylist(input)
            when is_list(input) and tuple_size(hd(input)) == 2 and is_atom(elem(hd(input), 0))

  def rust_way(template, input) do
    HandlebarsRs.Native.render(template, input_to_string_map(input))
  end

  defp input_to_string_map(input) when is_map(input) do
    Map.new(input, fn {k, v} -> {to_string(k), input_to_string_map(v)} end)
  end

  defp input_to_string_map(input) when is_keylist(input) do
    Map.new(input, fn {k, v} -> {to_string(k), input_to_string_map(v)} end)
  end

  defp input_to_string_map(input) when is_list(input) do
    Enum.map(input, &input_to_string_map/1)
  end

  defp input_to_string_map(input) when is_binary(input) do
    input
  end

  defp input_to_string_map(input) do
    to_string(input)
  end

  def zappa_way(template, input) do
    input = input_to_keylist(input)

    {:ok, eex_template} = Zappa.compile(template)
    EEx.eval_string(eex_template, input)
  end

  defp input_to_keylist(input) when is_map(input) do
    Enum.map(input, fn
      {k, v} when is_atom(k) -> {k, input_to_keylist(v)}
      {k, v} when is_binary(k) -> {String.to_atom(k), input_to_keylist(v)}
      _ -> raise "unsupported"
    end)
  end

  defp input_to_keylist(input) when is_keylist(input) do
    Enum.map(input, fn {k, v} -> {k, input_to_keylist(v)} end)
  end

  defp input_to_keylist(input) when is_list(input) do
    Enum.map(input, &input_to_keylist/1)
  end

  defp input_to_keylist(input), do: input
end
