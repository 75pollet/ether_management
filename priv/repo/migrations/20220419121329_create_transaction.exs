defmodule EtherManagement.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :hash, :string, primary_key: true
      add :complete, :boolean, default: false
      add :from, :string
      add :to, :string
      add :value, :string
      add :gas_price, :string
      add :block_number, :integer
      add :block_hash, :string
      add :transaction_index, :string
      add :nonce, :string
      add :input, :string
      add :gas, :string
    end
  end
end
