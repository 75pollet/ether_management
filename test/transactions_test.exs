defmodule EtherManagement.TranscationsTest do
  use EtherManagement.DataCase
  alias EtherManagement.Transactions

  test "create_transaction/1 with valid data creates a transaction" do
    valid_attrs = %{
      "blockHash" => "0xbaee22af41ce5cb4d28a6a377da26f4fc4f9d893fdfaa6878fb732f42367a947",
      "blockNumber" => "0x4b9b05",
      "from" => "0x0fe426d8f95510f4f0bac19be5e1252c4127ee00",
      "gas" => "0x5208",
      "gasPrice" => "0x4a817c800",
      "hash" => "0x7b6d0e8d812873260291c3f8a9fa99a61721a033a01e5c5af3ceb5e1dc9e7bd0",
      "input" => "0x",
      "nonce" => "0x2",
      "r" => "0xb0a50a9b5e11e36e564d985f3590173a40f231a04c6bfd6132d87244b5b45bcb",
      "s" => "0xa936a6f53d7e001a5f5ba6ca182e7e204a7ed0b8c5a7b874041a179d6e1e994",
      "to" => "0x4848535892c8008b912d99aaf88772745a11c809",
      "transactionIndex" => "0xa0",
      "type" => "0x0",
      "v" => "0x25",
      "value" => "0x526e615a87b5000"
    }

    assert {:ok, transaction} = Transactions.create_transaction(valid_attrs)
    assert transaction.block_number == 4
    assert transaction.from == "0x0fe426d8f95510f4f0bac19be5e1252c4127ee00"
  end
end
