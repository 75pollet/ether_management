defmodule EtherManagement.Transactions do
  @moduledoc """
  This is the `transactions` context. 
  """
  alias EtherManagement.Repo
  alias EtherManagement.Transactions.Transaction
  alias EtherManagement.Utils

  @doc """
  `EtherManagement.Transactions.create_transaction/1` saves transaction details to the database.
  """
  @spec create_transaction(map()) :: {:ok, %Transaction{}} | {:error, Ecto.Changeset.t()}
  def create_transaction(attrs) do
    attrs
    |> Utils.sanitize_transaction_keys()
    |> convert_block_number_to_decimal()
    |> Transaction.changeset()
    |> Repo.insert()
  end

  @doc """
  `EtherManagement.Transactions.update_incomplete_transactions/1` performs updates to the incomplete transactions 
  whose block confirmations are greater than or equal to 2
  """
  @spec update_incomplete_transactions(integer()) :: {integer(), nil | [term()]}
  def update_incomplete_transactions(new_block_number) do
    new_block_number
    |> Transaction.update_incomplete_transactions_query()
    |> Repo.update_all([])
  end

  @doc """
  `EtherManagement.Transactions.all_transactions/0` returns a list of all available transactions.
  """
  def all_transactions do
    Repo.all(Transaction)
  end

  defp convert_block_number_to_decimal(%{"block_number" => block_number} = attrs) do
    Map.replace(attrs, "block_number", Utils.convert_hex_to_decimal(block_number))
  end

  defp convert_block_number_to_decimal(attrs) do
    attrs
  end
end
