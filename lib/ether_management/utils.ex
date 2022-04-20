defmodule EtherManagement.Utils do
  @moduledoc """
  This module contains helper functions that can be reused accrossed the codebase
  """

  @doc """
  `EtherManagement.Utils.sanitize_transaction_keys/1` converts string keys on a map from camelcase
  to undercores.
  """
  @spec sanitize_transaction_keys(map()) :: map()
  def sanitize_transaction_keys(transactions) do
    transactions
    |> Enum.map(fn {key, value} -> {Macro.underscore(key), value} end)
    |> Enum.into(%{})
  end

  @doc """
  `EtherManagement.Utils.convert_hex_to_decimal/1` converts values from hexadecimal to decimal
  """
  @spec convert_hex_to_decimal(String.t()) :: integer()
  def convert_hex_to_decimal("0x" <> hex) do
    {int, _} = Integer.parse(hex, 16)
    int
  end
end
