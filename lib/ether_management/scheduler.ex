defmodule EtherManagement.Scheduler do
  @moduledoc """
  This module contains a repetitive process that performs the task of updating 
  incomplete transactions whose block confirmations are greater than or equal
  to 2.
  """
  alias EtherManagement.EtherScanApi
  alias EtherManagement.Utils

  def start_link(_) do
    Task.start_link(fn -> update_transactions() end)
  end

  def update_transactions() do
    schedule_next_update()

    receive do
      :update_transactions ->
        EtherManagement.Transactions.update_incomplete_transactions(new_block_number())

        update_transactions()
    end
  end

  def schedule_next_update() do
    Process.send_after(self(), :update_transactions, 20000)
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  defp new_block_number() do
    case EtherScanApi.fetch_lastest_block_number() do
      {:ok, result} -> Utils.convert_hex_to_decimal(result)
      {:error, _} -> 0
    end
  end
end
