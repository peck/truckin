defmodule Truckin.Repo do
  use Ecto.Repo,
    otp_app: :truckin,
    adapter: Ecto.Adapters.Postgres
end
