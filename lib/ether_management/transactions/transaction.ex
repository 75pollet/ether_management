defmodule EtherManagement.Transactions.Transaction do
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
  end
end
