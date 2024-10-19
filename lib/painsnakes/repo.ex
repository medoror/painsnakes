defmodule Painsnakes.Repo do
  use Ecto.Repo,
    otp_app: :painsnakes,
    adapter: Ecto.Adapters.Postgres
end
