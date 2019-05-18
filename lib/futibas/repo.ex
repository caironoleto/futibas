defmodule Futibas.Repo do
  use Ecto.Repo,
    otp_app: :futibas,
    adapter: Ecto.Adapters.Postgres
end
