defmodule EtherManagementWeb.EtherManagementController do
  use EtherManagementWeb, :controller

  alias EtherManagement.EtherScanApi
  alias EtherManagement.Transactions

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"new_ether" => %{"tx_hash" => tx_hash}}) do
    with {:ok, transaction} <- EtherScanApi.fetch_transaction(tx_hash),
         {:ok, _saved_transaction} <- EtherManagement.Transactions.create_transaction(transaction) do
      conn
      |> put_flash(:info, "Transaction Received!")
      |> redirect(to: Routes.ether_management_path(conn, :index))
    else
      {:error,
       %Ecto.Changeset{
         errors: [
           hash:
             {"has already been taken",
              [constraint: :unique, constraint_name: "transactions_pkey"]}
         ]
       }} ->
        conn
        |> put_flash(:error, "Transaction has already been entered. Please try again!")
        |> redirect(to: Routes.ether_management_path(conn, :new))

      {:error, _} ->
        conn
        |> put_flash(:error, "There seems to be problem kindly retry")
        |> redirect(to: Routes.ether_management_path(conn, :new))
    end
  end

  def index(conn, _params) do
    transactions = Transactions.all_transactions()
    render(conn, "index.html", transactions: transactions)
  end
end
