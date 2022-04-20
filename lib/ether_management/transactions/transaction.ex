defmodule EtherManagement.Transactions.Transaction do
  @moduledoc """
  This module is the schema for transactions
  """
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @primary_key {:hash, :string, autogenerate: false}
  schema "transactions" do
    field :complete, :boolean, default: false
    field :from, :string
    field :to, :string
    field :value, :string
    field :gas_price, :string
    field :block_number, :integer
    field :block_hash, :string
    field :transaction_index, :string
    field :nonce, :string
    field :input, :string
    field :gas, :string
  end

  @spec changeset(map()) :: Ecto.Changeset.t()
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [
      :hash,
      :complete,
      :from,
      :to,
      :value,
      :gas_price,
      :block_number,
      :block_hash,
      :transaction_index,
      :nonce,
      :input,
      :gas
    ])
    |> unique_constraint(:hash, name: :transactions_pkey)
  end

  @doc """
  returns a query that updates the `complete` column on incomplete transactions to `true`
  """
  @spec update_incomplete_transactions_query(integer) :: Ecto.Query.t()
  def update_incomplete_transactions_query(new_block_number) do
    from(t in __MODULE__,
      where: t.complete == false and ^new_block_number - t.block_number >= 2,
      update: [set: [complete: true]]
    )
  end
end
