defmodule ScorerApi.Repo do
  use Ecto.Repo,
    otp_app: :scorer_api,
    adapter: Ecto.Adapters.Postgres
end
