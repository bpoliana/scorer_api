defmodule ScorerApi.Api do
  alias ScorerApi.Workers.ScorerWorker

  def get_users() do
    server_impl().get_users()
  end

  defp server_impl() do
    Application.get_env(:api, :scorer_server, ScorerWorker)
  end
end
