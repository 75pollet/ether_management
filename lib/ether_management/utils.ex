defmodule EtherManagement.Utils do
  def santize_transaction_keys(transactions) do
    transactions
    |> Enum.map(fn {key, value} -> {Macro.underscore(key), value} end)
    |> Enum.into(%{})
  end

  def convert_hex_to_decimal("0x" <> hex) do
    {int, _} = Integer.parse(hex)
    int
  end
end
