defmodule LiveSelectTest.Repo do
  use Ecto.Repo,
    otp_app: :live_select_test,
    adapter: Ecto.Adapters.Postgres
end
