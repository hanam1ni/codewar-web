defmodule Codewar.Repo do
  use Ecto.Repo,
    otp_app: :codewar,
    adapter: Ecto.Adapters.Postgres
end
