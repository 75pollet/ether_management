defmodule EtherManagement.Transactions do
  alias EtherManagement.Repo
  alias EtherManagement.Transactions.Transaction
  alias EtherManagement.Utils

  def create_transaction(attrs) do
    attrs
    |> Utils.santize_transaction_keys()
    |> convert_block_number_to_decimal()
    |> Transaction.changeset()
    |> Repo.insert()
  end

  def update_incomplete_transactions(new_block_number) do
    new_block_number
    |> Transaction.update_incomplete_transactions_query()
    |> Repo.update_all([])
  end

  defp convert_block_number_to_decimal(%{"block_number" => block_number} = attrs) do
    Map.replace(attrs, "block_number", Utils.convert_hex_to_decimal(block_number))
  end

  defp convert_block_number_to_decimal(attrs) do
    attrs
  end
end
