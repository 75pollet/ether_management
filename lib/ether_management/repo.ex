defmodule EtherManagement.Repo do
  use Ecto.Repo,
    otp_app: :ether_management,
    adapter: Ecto.Adapters.Postgres
end
