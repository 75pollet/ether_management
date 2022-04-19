defmodule EtherManagement.EtherScanApi do
  @moduledoc """
    This module handles interactions with the etherscan API.
  """

  @api_key Application.fetch_env!(:ether_management, :etherscan_api_key)
  @base_url "https://api.etherscan.io/api?"
  @headers [Accept: "Application/json"]

  @doc """
  Fetches the transaction with the given hash from the etherscan api.
  """
  @spec fetch_transaction(string()) :: {:ok, map()} | {:error, any()}
  def fetch_transaction(tx_hash) do
    tx_hash
    |> fetch_transaction_url()
    |> HTTPoison.get(@headers)
    |> handle_response()
  end

  defp fetch_transaction_url(tx_hash) do
    "#{@base_url}module=proxy&action=eth_getTransactionByHash&txhash=#{tx_hash}&apikey=#{@api_key}"
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: status_code}})
       when status_code in 200..399 do
    case Jason.decode(body) do
      {:ok, %{"result" => result, "id" => _id}} -> {:ok, result}
      {_, result} -> {:error, result}
    end
  end

  defp handle_response({_, response}) do
    {:error, response}
  end
end
