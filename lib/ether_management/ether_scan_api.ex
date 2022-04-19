defmodule EtherManagement.EtherScanApi do
  @api_key "V8GVRUSPVRDBR3GUVSGPQXHHCKXV3TUKE5"
  @base_url "https://api.etherscan.io/api?"
  @headers [Accept: "Application/json"]

  def fetch_transaction(tx_hash) do
    with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <-
           HTTPoison.get(
             "#{@base_url}module=proxy&action=eth_getTransactionByHash&txhash=#{tx_hash}&apikey=#{@api_key}",
             @headers
           ),
         {:ok, %{"result" => result}} <- Jason.decode(body) do
      {:ok, result}
    else
      {_, error} -> {:error, error}
    end
  end
end
