defmodule EtherManagement.EtherScanApiTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
    :ok
  end

  test "fetch_transcations/1 for valid hash" do
    use_cassette "with valid transaction hash will succeed" do
      assert {:ok, _results} =
               EtherManagement.EtherScanApi.fetch_transaction(
                 "0x7b6d0e8d812873260291c3f8a9fa99a61721a033a01e5c5af3ceb5e1dc9e7bd0"
               )
    end
  end

  test "fetch_transcations/1 for invalid hash" do
    use_cassette " with invalid transaction hash will fail" do
      assert {:error, _results} = EtherManagement.EtherScanApi.fetch_transaction("invalid")
    end
  end

  test "fetch_fetch_lastest_block_number/0" do
    use_cassette "fetch latest block number" do
      assert {:ok, _results} = EtherManagement.EtherScanApi.fetch_lastest_block_number()
    end
  end
end
