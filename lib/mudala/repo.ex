defmodule Mudala.Repo do
  use Ecto.Repo,
    otp_app: :mudala,
    adapter: Ecto.Adapters.Postgres
end
